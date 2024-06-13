import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';

part 'sentry_span_measurement_type.freezed.dart';

@freezed
class SentrySpanMeasurementType with _$SentrySpanMeasurementType {
  /// Charge amount at time of charge
  factory SentrySpanMeasurementType.chargeAmount(num value) =>
      SentrySpanMeasurementType._create(
        name: 'charge_amount',
        value: value,
        unit: SentryMeasurementUnit.none,
      );

  /// Vote amount at the time of voting
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