import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';

part 'sentry_span_measurement_type.freezed.dart';

@freezed
class SentrySpanMeasurementType with _$SentrySpanMeasurementType {
  /// チャージ時のチャージ金額
  factory SentrySpanMeasurementType.chargeAmount(num value) =>
      SentrySpanMeasurementType._create(
        name: 'charge_amount',
        value: value,
        unit: SentryMeasurementUnit.none,
      );

  /// 投票時の投票金額
  factory SentrySpanMeasurementType.bettingAmount(num value) =>
      SentrySpanMeasurementType._create(
        name: 'betting_amount',
        value: value,
        unit: SentryMeasurementUnit.none,
      );

  const factory SentrySpanMeasurementType._create({
    required String name,
    required num value,
    required SentryMeasurementUnit? unit,
  }) = _SentrySpanMeasurementType;
}