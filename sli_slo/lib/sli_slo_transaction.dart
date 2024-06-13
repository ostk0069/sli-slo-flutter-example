import 'dart:async';

import 'package:sli_slo/extension/enum.dart';
import 'package:sli_slo/extension/object.dart';
import 'package:sli_slo/extension/string.dart';
import 'package:sli_slo/foundation/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sentry/sentry.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/model/sentry_span_measurement_type.dart';
import 'package:sli_slo/model/sentry_span_tag_type.dart';
import 'package:sli_slo/model/sli_slo_transaction_event.dart';

final sliSloTransactionProvider =
Provider.family<SLISLOTransaction, SLISLOTransactionParams>(
      (ref, param) => SLISLOTransaction(
    name: param.name,
    description: param.description,
  ),
);

@immutable
class SLISLOTransactionParams {
  const SLISLOTransactionParams({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;
}

class SLISLOTransaction {
  SLISLOTransaction({
    required this.name,
    required this.description,
  });

  /// SLOの名前
  final String name;

  /// SLOの説明
  final String description;

  /// 計測中のトランザクション(計測していないときはnull)
  @visibleForTesting
  ISentrySpan? transaction;

  /// 送信予定のステータス
  @visibleForTesting
  SpanStatus? status;

  /// 追加したTag Keys
  final List<SentrySpanTagType> tagTypes = [];

  /// 追加したMeasurement
  @visibleForTesting
  final List<SentrySpanMeasurementType> measurementTypes = [];

  /// 追加した子Span
  @visibleForTesting
  final List<SLISLOTransactionChild> children = [];

  /// SLOを計測中かどうか
  bool get isRunning => transaction != null;

  /// SLOを待機中かどうか
  bool get isIdle => transaction == null;

  bool get disposed => _subscription == null || _controller == null;

  StreamController<SLISLOTransactionEventModel>? _controller;

  StreamSubscription<SLISLOTransactionEventModel>? _subscription;

  static const operationName = 'slo';

  @Deprecated('Use isRunning instead')
  SLISLOTransaction? takeIfIsRunning() => takeIf((slo) => slo.isRunning);

  /// 計測開始
  /// 中断検知のため、計測開始時にsharedPreferenceの書き込みが存在する
  /// 他のsharedPreferenceの書き込み・消去が同時期に実行される場合、後発が実行されないことがあるので注意
  void start() {
    if (!disposed) {
      _dispose();
    }
    _controller = StreamController<SLISLOTransactionEventModel>();
    _subscription = _controller?.stream.asyncMap((event) async {
      await event.when(
        start: (stackTrace) async => await startEvent(
          stackTrace: stackTrace,
        ),
        startChild: (operationName, operationType, stackTrace) async =>
        await startChildEvent(
          operationName: operationName,
          operationType: operationType,
          stackTrace: stackTrace,
        ),
        setChildStatusAndFinish:
            (operationName, spanStatus, stackTrace) async =>
        await setChildStatusAndFinishEvent(
          operationName: operationName,
          spanStatus: spanStatus,
          stackTrace: stackTrace,
        ),
        setTag: (type, stackTrace) async => await setTagEvent(
          type: type,
          stackTrace: stackTrace,
        ),
        setMeasurement: (type, stackTrace) async => await setMeasurementEvent(
          type: type,
          stackTrace: stackTrace,
        ),
        setStatusWhenNull: (spanStatus, stackTrace) async =>
        await setStatusWhenNullEvent(
          newStatus: spanStatus,
          stackTrace: stackTrace,
        ),
        finish: (stackTrace) async => await finishEvent(
          stackTrace: stackTrace,
        ),
        finishWithDisposeSkip: (stackTrace) async => await finishEvent(
          stackTrace: stackTrace,
        ),
      );
      return event;
    }).listen((event) {
      if (event is SLISLOTransactionEventFinish) {
        _dispose();
      }
    });
    _controller
        ?.add(SLISLOTransactionEventModel.start(stackTrace: StackTrace.current));
  }

  /// 計測終了と同時に計測開始も実行したい時に利用する
  /// 基本的にstartを利用するが計測中にアプリ外に飛ぶものはstart -> startが可能なので、その場合はfinishIfRunningAndStartを利用する
  /// WARNING: takeIfIsRunning()を事前に実行しないこと
  /// NOTE: 計測終了と計測開始を実行すると、finishによるstreamControllerの購読とstartによるstreamControllerの破棄の順番が保証されないため
  void finishIfRunningAndStart(SpanStatus finishStatus) {
    if (!isRunning) {
      start();
      return;
    }
    if (disposed) {
      _log(
        message: '$name SLO finishAndStart() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }

    _controller?.add(
      SLISLOTransactionEventModel.setStatusWhenNull(
        spanStatus: finishStatus,
        stackTrace: StackTrace.current,
      ),
    );
    _controller?.add(
      SLISLOTransactionEventModel.finishWithDisposeSkip(
        stackTrace: StackTrace.current,
      ),
    );
    _controller?.add(
      SLISLOTransactionEventModel.start(
        stackTrace: StackTrace.current,
      ),
    );
  }

  void startChild({
    required String operationName,
    required SentrySpanChildOperationType operationType,
  }) {
    if (disposed) {
      _log(
        message: '$name SLO startChild() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.startChild(
        operationName: operationName,
        operationType: operationType,
        stackTrace: StackTrace.current,
      ),
    );
  }

  void setChildStatusAndFinish({
    required String operationName,
    required SpanStatus spanStatus,
  }) {
    if (disposed) {
      _log(
        message: '$name SLO setChildStatusAndFinish() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.setChildStatusAndFinish(
        operationName: operationName,
        spanStatus: spanStatus,
        stackTrace: StackTrace.current,
      ),
    );
  }

  void setTag({
    required SentrySpanTagType type,
  }) {
    if (disposed) {
      _log(
        message: '$name SLO setTag() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.setTag(
        type: type,
        stackTrace: StackTrace.current,
      ),
    );
  }

  void setMeasurement({
    required SentrySpanMeasurementType type,
  }) {
    if (disposed) {
      _log(
        message: '$name SLO setMeasurement() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.setMeasurement(
        type: type,
        stackTrace: StackTrace.current,
      ),
    );
  }

  void setStatusWhenNull(SpanStatus spanStatus) {
    if (disposed) {
      _log(
        message: '$name SLO setStatusWhenNull() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.setStatusWhenNull(
        spanStatus: spanStatus,
        stackTrace: StackTrace.current,
      ),
    );
  }

  /// 計測終了
  /// 中断検知のため、計測終了時にsharedPreferenceの消去処理が存在する
  /// 他のsharedPreferenceの書き込み・消去が同時期に実行される場合、後発が実行されないことがあるので注意
  void finish() {
    if (disposed) {
      _log(
        message: '$name SLO finish() called when disposed',
        stackTrace: StackTrace.current,
        isError: true,
      );
      return;
    }
    _controller?.add(
      SLISLOTransactionEventModel.finish(
        stackTrace: StackTrace.current,
      ),
    );
  }

  void _dispose() {
    _subscription?.cancel();
    _subscription = null;
    _controller?.close();
    _controller = null;
  }

  /// 計測開始
  @visibleForTesting
  Future<void> startEvent({
    required StackTrace stackTrace,
  }) async {
    if (isRunning) {
      // 計測開始時にはnullのはずなので強制終了する
      _log(
        message: '$name SLO start() called when transaction not finished',
        stackTrace: stackTrace,
        isError: true,
      );
      await finishEvent(
        stackTrace: stackTrace,
      );
    }

    _log(
      message: '🔥 SLO Transaction Started - $name',
      stackTrace: stackTrace,
    );
    transaction = Sentry.startTransaction(
      name,
      operationName,
      description: description,
      // 10分以上経過してもfinishが発火されない場合は強制終了させる
      autoFinishAfter: const Duration(minutes: 10),
    );
    await setTagEvent(
      type: SentrySpanTagType.send(SentrySpanTagSendType.normal),
      stackTrace: stackTrace,
    );
    _addBreadcrumb('start');
  }

  /// すでに計測中のTransactionに対して子要素の計測対象を追加する処理
  /// 基本的にDioでのinterceptor内でのみ利用する
  /// eg. 精算処理のSLO計測時にAPIのpost処理を子要素として計測する
  @visibleForTesting
  Future<void> startChildEvent({
    required String operationName,
    required SentrySpanChildOperationType operationType,
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // Span追加時にはtransactionは存在するはずなので、ない場合はSentryにエラーだけ送る
      _log(
        message: '$name SLO startChild() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );
      return;
    }

    _log(
      message: '🔥 SLO Transaction Child Started - child name: $operationName',
      stackTrace: stackTrace,
    );
    final spanChild = transaction?.startChild(
      operationName,
      description: operationType.snakeCaseName,
    );
    if (spanChild != null) {
      children.add(
        SLISLOTransactionChild(
          operationName: operationName,
          span: spanChild,
        ),
      );
    }
  }

  /// すでに計測中のTransactionに対して子要素の計測対象を計測終了する処理
  /// 基本的にDioでのinterceptor内でのみ利用する
  @visibleForTesting
  Future<void> setChildStatusAndFinishEvent({
    required String operationName,
    required SpanStatus spanStatus,
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // Span追加時にはtransactionは存在するはずなので、ない場合はSentryにエラーだけ送る
      _log(
        message: '$name SLO startChild() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );
      return;
    }

    _log(
      message:
      '🔥 SLO Transaction Child Set Status - child name: $operationName',
      stackTrace: stackTrace,
    );

    final filteredChildren = children.where(
          (child) => child.operationName == operationName,
    );
    for (final child in filteredChildren) {
      if (child.span.status == null) {
        child.span.status ??= spanStatus;
        await child.span.finish();
      }
    }
  }

  @visibleForTesting
  Future<void> setTagEvent({
    required SentrySpanTagType type,
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // Span追加時にはtransactionは存在するはずなので、ない場合はSentryにエラーだけ送る
      _log(
        message: '$name SLO addTag() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );
      return;
    }

    _log(
      message:
      '🔥 SLO Transaction Tag Set - key: ${type.key}, value: ${type.value.toSnakeCase()}',
      stackTrace: stackTrace,
    );
    tagTypes.add(type);
    transaction?.setTag(
      type.key,
      type.value.toSnakeCase(),
    );
  }

  @visibleForTesting
  Future<void> setMeasurementEvent({
    required SentrySpanMeasurementType type,
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // Span追加時にはtransactionは存在するはずなので、ない場合はSentryにエラーだけ送る
      _log(
        message:
        '$name SLO setMeasurement() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );
      return;
    }
    _log(
      message:
      '🔥 SLO Transaction Measurement Set - name: ${type.name}, value: ${type.value}, unit: ${type.unit}',
      stackTrace: stackTrace,
    );
    measurementTypes.add(type);
    transaction?.setMeasurement(
      type.name.toSnakeCase(),
      type.value,
      unit: type.unit,
    );
  }

  @visibleForTesting
  Future<void> setStatusWhenNullEvent({
    required SpanStatus newStatus,
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // 計測終了時にはtransactionは存在するはずなのでない場合はSentryにエラーだけ送る
      _log(
        message:
        '$name SLO setStatusWhenNull() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );
      return;
    }
    // unknownやunknownErrorはfailureRateに含めないため、dataLossに変換する
    final convertedStatus = newStatus == const SpanStatus.unknown() ||
        newStatus == const SpanStatus.unknownError()
        ? const SpanStatus.dataLoss()
        : newStatus;

    _log(
      message: '🔥 SLO Transaction Status Set - $convertedStatus',
      stackTrace: stackTrace,
    );
    status ??= convertedStatus;
    transaction?.status ??= convertedStatus;
    if (status != null) {
      _addBreadcrumb('set status - ${convertedStatus.toString()}');
    }
  }

  @visibleForTesting
  Future<void> finishEvent({
    required StackTrace stackTrace,
  }) async {
    if (isIdle) {
      // 計測終了時にはtransactionは存在するはずなのでない場合はSentryにエラーだけ送る
      _log(
        message: '$name SLO finish() called when transaction not started',
        stackTrace: stackTrace,
        isError: true,
      );

      return;
    }
    await setTagEvent(
      type: SentrySpanTagType.transactionStatus(
        status,
      ),
      stackTrace: stackTrace,
    );
    _log(
      message: '🔥 SLO Transaction Finish - status: $status',
      stackTrace: stackTrace,
    );
    _addBreadcrumb('finish - status: ${status.toString()}');

    if (status == null) {
      // 計測終了時にはstatusはset済みのはずなのでない場合はSentryにエラーだけ送る
      _log(
        message: '$name SLO finish() called when status not set',
        stackTrace: stackTrace,
        isError: true,
      );
      status = const SpanStatus.dataLoss();
      transaction?.status = const SpanStatus.dataLoss();
    }
    await transaction?.finish();
    status = null;
    for (final type in tagTypes) {
      transaction?.removeTag(type.key);
    }
    tagTypes.clear();
    measurementTypes.clear();
    children.clear();
    transaction = null;
  }

  void _addBreadcrumb(String action) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        category: 'app.state',
        type: 'slo_action',
        data: <String, dynamic>{
          'action': action,
          'slo_name': name,
          'slo_description': description,
        },
      ),
    );
  }

  void _log({
    required String message,
    required StackTrace stackTrace,
    bool isError = false,
  }) {
    final log = isError ? logger.e : logger.i;
    log(message, stackTrace: stackTrace);
  }
}

@immutable
class SLISLOTransactionChild {
  const SLISLOTransactionChild({
    required this.operationName,
    required this.span,
  });

  final String operationName;
  final ISentrySpan span;
}