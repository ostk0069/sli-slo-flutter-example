import 'package:built_collection/built_collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sli_slo/sli_slo_transaction.dart';

final sliSloTransactionHolderProvider = Provider<SLISLOTransactionHolderImpl>(
      (ref) => SLISLOTransactionHolderImpl(
    ref.watch(
      sliSloTransactionProvider(
        const SLISLOTransactionParams(
          name: 'playground_test_slo_1',
          description: 'PlaygroundでのTransactionのTest',
        ),
      ),
    ),
    ref.watch(
      sliSloTransactionProvider(
        const SLISLOTransactionParams(
          name: 'playground_test_slo_2',
          description: 'PlaygroundでのTransactionのTest',
        ),
      ),
    ),
  ),
);

abstract class SLISLOTransactionHolder {
  BuiltList<SLISLOTransaction> get transactions;

  BuiltList<SLISLOTransaction> get runningSLOTransactions =>
      transactions.where((transaction) => transaction.isRunning).toBuiltList();
}

/// A HolderClass that collectively defines the SLOs to be measured
/// Designed to be separate instances so that multiple SLOs can be measured at the same time
class SLISLOTransactionHolderImpl extends SLISLOTransactionHolder {
  SLISLOTransactionHolderImpl(
      this.playgroundTest1,
      this.playgroundTest2,
      );

  final SLISLOTransaction playgroundTest1;

  final SLISLOTransaction playgroundTest2;

  /// Get the SLOTransaction being measured
  /// NOTE: If you create a new measurement target, add it here.
  @override
  BuiltList<SLISLOTransaction> get transactions => [
    playgroundTest1,
    playgroundTest2
  ].toBuiltList();
}