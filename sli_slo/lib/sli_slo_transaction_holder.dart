import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sli_slo/sli_slo_transaction.dart';

final sliSloTransactionHolderProvider = Provider<SLOTransactionHolderImpl>(
      (ref) => SLOTransactionHolderImpl(
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

abstract class SLOTransactionHolder {
  BuiltList<SLISLOTransaction> get transactions;

  BuiltList<SLISLOTransaction> get runningSLOTransactions =>
      transactions.where((transaction) => transaction.isRunning).toBuiltList();
}

/// 計測するSLOをまとめて定義するHolderClass
/// 別々のインスタンスにすることで同時に複数のSLOを計測することも視野に入れた設計にしている
class SLOTransactionHolderImpl extends SLOTransactionHolder {
  SLOTransactionHolderImpl(
      this.playgroundTest1,
      this.playgroundTest2,
      );

  @visibleForTesting
  final SLISLOTransaction playgroundTest1;

  @visibleForTesting
  final SLISLOTransaction playgroundTest2;

  /// 計測中のSLOTransactionを取得する
  /// NOTE: 新規の計測対象を作成した場合はここに追加する
  @override
  BuiltList<SLISLOTransaction> get transactions => [
    playgroundTest1,
    playgroundTest2
  ].toBuiltList();
}