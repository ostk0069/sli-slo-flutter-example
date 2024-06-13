import 'package:sli_slo/extension/string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';

part 'sentry_span_tag_type.freezed.dart';

/// Anything that gives information that can be classified for a Transaction
/// For numerical values such as amount or image size, it is recommended to use Measurement instead of Tag.
@freezed
class SentrySpanTagType with _$SentrySpanTagType {
  /// Transactionのstatus
  factory SentrySpanTagType.transactionStatus(
      SpanStatus? status,
      ) =>
      SentrySpanTagType._create(
        key: 'transaction_status',
        // statusがnullの場合は判別がつくようにdataLossではなく、emptyを送る
        value: status != null ? status.toString() : 'empty',
      );

  /// bank code
  factory SentrySpanTagType.bankCode(
      String code,
      ) =>
      SentrySpanTagType._create(
        key: 'bank_code',
        value: code,
      );

  /// transaction sending type
  factory SentrySpanTagType.send(
      SentrySpanTagSendType type,
      ) =>
      SentrySpanTagType._create(
        key: 'send_type',
        value: type.name.toSnakeCase(),
      );

  /// Error code when charging WebView
  /// Send 200 on success
  factory SentrySpanTagType.webViewErrorCode(
      int type,
      ) =>
      SentrySpanTagType._create(
        key: 'web_view_error_code',
        value: type.toString(),
      );

  /// Error message on WebView charge
  /// Send success for success, cancellation for cancellation
  factory SentrySpanTagType.webViewErrorMessage(
      String value,
      ) =>
      SentrySpanTagType._create(
        key: 'web_view_error_message',
        value: value,
      );

  factory SentrySpanTagType.connectivityResult(
      String connectivityResultName,
      ) =>
      SentrySpanTagType._create(
        key: 'connectivity_result',
        value: connectivityResultName,
      );

  const factory SentrySpanTagType._create({
    required String key,
    required String value,
  }) = _SentrySpanTagType;
}

enum SentrySpanTagSendType {
  normal,

  /// intrruption transaction
  discontinued,
}

enum SentrySpanTagAuthenticateRouteType {
  login,
  register,
}

enum SentrySpanTagRegisterAccountReachedPageType {
  /// input email
  inputEmail,

  /// input user information for verification
  inputInfo,

  /// set password
  inputPassword,

  /// confirm input
  confirmInput,
  ;
}