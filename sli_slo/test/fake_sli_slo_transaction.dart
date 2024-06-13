import 'package:sli_slo/foundation/current_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sli_slo/sli_slo_transaction.dart';

class FakeSLISLOTransaction extends SLISLOTransaction {
  @visibleForTesting
  FakeSLISLOTransaction({
    String? name,
    String? description,
    CurrentTime? currentTime,
  }) : super(
    name: name ?? 'test',
    description: description ?? 'test description',
  );
}
