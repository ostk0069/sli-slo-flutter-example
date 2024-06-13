import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/sli_slo_transaction_holder.dart';

/// すでに計測中のTransactionに対して子要素の計測対象を追加するクラス
/// eg. 精算処理のSLO計測時にAPIのpost処理を子要素として計測する
class SLISLODioInterceptorWrapper extends InterceptorsWrapper {
  SLISLODioInterceptorWrapper(
      this._sloTransactionHolder,
      );

  final SLOTransactionHolderImpl _sloTransactionHolder;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 現在計測中のTransactionを取得し、Dioの計測の開始情報を付与する
    for (final transaction in _sloTransactionHolder.runningSLOTransactions) {
      transaction.startChild(
        operationName: options.path,
        operationType: SentrySpanChildOperationType.api,
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) {
    // 現在計測中のTransactionを取得し、Dioの計測の終了情報を付与する
    for (final transaction in _sloTransactionHolder.runningSLOTransactions) {
      transaction.setChildStatusAndFinish(
        operationName: response.requestOptions.path,
        spanStatus: const SpanStatus.ok(),
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 現在計測中のTransactionを取得し、Dioの計測の終了情報を付与する
    for (final transaction in _sloTransactionHolder.runningSLOTransactions) {
      transaction.setChildStatusAndFinish(
        operationName: err.requestOptions.path,
        spanStatus: err.response?.statusCode != null
            ? SpanStatus.fromHttpStatusCode(
          err.response!.statusCode!,
          fallback: const SpanStatus.dataLoss(),
        )
            : const SpanStatus.dataLoss(),
      );
    }
    handler.next(err);
  }
}