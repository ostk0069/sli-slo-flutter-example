import 'package:sentry/sentry.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/model/sentry_span_measurement_type.dart';
import 'package:sli_slo/model/sentry_span_tag_type.dart';
import 'package:sli_slo/sli_slo_transaction.dart';
import 'package:test/test.dart';

import 'fake_sli_slo_transaction.dart';

void main() {
  late SLISLOTransaction sloTransaction;
  const status = SpanStatus.ok();
  const emptyTagTypes = <SentrySpanTagType>[];
  final initialTagTypes = [
    SentrySpanTagType.send(SentrySpanTagSendType.normal),
  ];
  final bankTagTypes = [
    SentrySpanTagType.send(SentrySpanTagSendType.normal),
    SentrySpanTagType.bankCode('test'),
  ];

  const emptyMeasurementTypes = <SentrySpanMeasurementType>[];

  setUp(() {
    sloTransaction = FakeSLISLOTransaction();
  });

  group('SLOTransaction', () {
    test('success', () async {
      await sloTransaction.startEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        initialTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );
      expect(
        sloTransaction.children.length,
        0,
      );

      await sloTransaction.setTagEvent(
        type: SentrySpanTagType.bankCode('test'),
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );
      expect(
        sloTransaction.children.length,
        0,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.children.length,
        0,
      );

      await sloTransaction.startChildEvent(
        operationName: 'test_child',
        operationType: SentrySpanChildOperationType.api,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.setChildStatusAndFinishEvent(
        operationName: 'test_child',
        spanStatus: const SpanStatus.ok(),
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.setStatusWhenNullEvent(
        newStatus: status,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        status,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.setStatusWhenNullEvent(
        newStatus: const SpanStatus.aborted(),
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        status,
      );
      expect(
        sloTransaction.tagTypes,
        bankTagTypes,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.finishEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        false,
      );
      expect(
        sloTransaction.isIdle,
        true,
      );
      expect(
        sloTransaction.transaction != null,
        false,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        emptyTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );
      expect(
        sloTransaction.children.length,
        0,
      );
    });

    test('finish called before set status', () async {
      await sloTransaction.startEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        initialTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );

      await sloTransaction.finishEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        false,
      );
      expect(
        sloTransaction.isIdle,
        true,
      );
      expect(
        sloTransaction.transaction != null,
        false,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        emptyTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );
    });

    test('finish called before start', () async {
      await sloTransaction.finishEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        false,
      );
      expect(
        sloTransaction.isIdle,
        true,
      );
      expect(
        sloTransaction.transaction != null,
        false,
      );
      expect(
        sloTransaction.status,
        null,
      );
      expect(
        sloTransaction.tagTypes,
        emptyTagTypes,
      );
      expect(
        sloTransaction.measurementTypes,
        emptyMeasurementTypes,
      );
    });

    test('duplicate child not send before send status', () async {
      await sloTransaction.startEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.children.length,
        0,
      );

      await sloTransaction.startChildEvent(
        operationName: 'test_child',
        operationType: SentrySpanChildOperationType.api,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.startChildEvent(
        operationName: 'test_child',
        operationType: SentrySpanChildOperationType.api,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      // ISentrySpanはmockを作成できないのでoperationNameのみを確認
      expect(
        sloTransaction.children.map((e) => e.operationName).toList(),
        [
          'test_child',
          'test_child',
        ],
      );

      await sloTransaction.setChildStatusAndFinishEvent(
        operationName: 'test_child',
        spanStatus: const SpanStatus.ok(),
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      // ISentrySpanはmockを作成できないのでoperationNameのみを確認
      expect(
        sloTransaction.children.map((e) => e.operationName).toList(),
        [
          'test_child',
          'test_child',
        ],
      );
    });

    test('duplicate child not send after send status', () async {
      await sloTransaction.startEvent(
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.children.length,
        0,
      );

      await sloTransaction.startChildEvent(
        operationName: 'test_child',
        operationType: SentrySpanChildOperationType.api,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.setChildStatusAndFinishEvent(
        operationName: 'test_child',
        spanStatus: const SpanStatus.ok(),
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      expect(
        sloTransaction.children.length,
        1,
      );

      await sloTransaction.startChildEvent(
        operationName: 'test_child',
        operationType: SentrySpanChildOperationType.api,
        stackTrace: StackTrace.empty,
      );
      expect(
        sloTransaction.isRunning,
        true,
      );
      expect(
        sloTransaction.isIdle,
        false,
      );
      expect(
        sloTransaction.transaction != null,
        true,
      );
      // ISentrySpanはmockを作成できないのでoperationNameのみを確認
      expect(
        sloTransaction.children.map((e) => e.operationName).toList(),
        [
          'test_child',
          'test_child',
        ],
      );
    });
  });
}