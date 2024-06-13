import 'package:sli_slo/extension/string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';

part 'sentry_span_tag_type.freezed.dart';

/// Transactionに対して分類できる情報を付与するもの
/// 金額や画像のサイズなどの数値のものはTagではなくMeasurementの利用を推奨する
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

  /// 銀行コード
  factory SentrySpanTagType.bankCode(
      String code,
      ) =>
      SentrySpanTagType._create(
        key: 'bank_code',
        value: code,
      );

  /// 送信方法
  factory SentrySpanTagType.send(
      SentrySpanTagSendType type,
      ) =>
      SentrySpanTagType._create(
        key: 'send_type',
        value: type.name.toSnakeCase(),
      );

  /// WebViewチャージ時のエラーコード
  /// 成功の場合は200を送る
  factory SentrySpanTagType.webViewErrorCode(
      int type,
      ) =>
      SentrySpanTagType._create(
        key: 'web_view_error_code',
        value: type.toString(),
      );

  /// WebViewチャージ時のエラーメッセージ
  /// 成功の場合は成功、キャンセルの場合はキャンセルを送る
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
  /// 通常送信
  normal,

  /// 中断送信
  discontinued,
}

enum SentrySpanTagAuthenticateRouteType {
  /// ログイン
  login,

  /// 新規登録
  register,
}

enum SentrySpanTagRegisterAccountReachedPageType {
  /// メールアドレスの入力
  inputEmail,

  /// ご本人情報の入力
  inputInfo,

  /// 暗証番号の設定
  inputPassword,

  /// 入力内容の確認
  confirmInput,
  ;
}