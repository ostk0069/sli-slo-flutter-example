import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/model/sentry_span_measurement_type.dart';
import 'package:sli_slo/model/sentry_span_tag_type.dart';

part 'sli_slo_transaction_event.freezed.dart';

@freezed
class SLISLOTransactionEventModel with _$SLISLOTransactionEventModel {
  const factory SLISLOTransactionEventModel.start({
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventStart;

  const factory SLISLOTransactionEventModel.startChild({
    required String operationName,
    required SentrySpanChildOperationType operationType,
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventStartChild;

  const factory SLISLOTransactionEventModel.setChildStatusAndFinish({
    required String operationName,
    required SpanStatus spanStatus,
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventSetChildStatusAndFinish;

  const factory SLISLOTransactionEventModel.setTag({
    required SentrySpanTagType type,
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventSetTag;

  const factory SLISLOTransactionEventModel.setMeasurement({
    required SentrySpanMeasurementType type,
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventSetMeasurement;

  const factory SLISLOTransactionEventModel.setStatusWhenNull({
    required SpanStatus spanStatus,
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventSetStatusWhenNull;

  const factory SLISLOTransactionEventModel.finish({
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventFinish;

  const factory SLISLOTransactionEventModel.finishWithDisposeSkip({
    required StackTrace stackTrace,
  }) = SLISLOTransactionEventFinishWithDisposeSkip;
}