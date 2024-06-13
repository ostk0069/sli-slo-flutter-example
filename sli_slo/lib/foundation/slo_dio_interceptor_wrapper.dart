import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/sli_slo_transaction_holder.dart';

/// Class to add the measurement target of a child element to a Transaction that is already being measured
/// eg. Measure API post process as a child element when measuring SLO of settlement process.
class SLISLODioInterceptorWrapper extends InterceptorsWrapper {
  SLISLODioInterceptorWrapper(
      this._sloTransactionHolder,
      );

  final SLISLOTransactionHolderImpl _sloTransactionHolder;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Obtains the Transaction currently being measured and assigns Dio measurement start information.
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
    // Obtains the Transaction currently being measured and gives Dio end-of-measurement information.
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
    // Obtains the Transaction currently being measured and gives Dio end-of-measurement information.
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