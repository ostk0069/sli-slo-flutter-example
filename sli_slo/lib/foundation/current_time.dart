import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

final currentTimeProvider = Provider<CurrentTime>((_) => CurrentTime());

abstract class CurrentTime {
  factory CurrentTime() = _CurrentTime;

  DateTime call();
}

class _CurrentTime implements CurrentTime {
  @override
  DateTime call() => DateTime.now();
}

@visibleForTesting
class FakeCurrentTime implements CurrentTime {
  FakeCurrentTime();

  static final defaultNow = DateTime(2000);

  DateTime now = defaultNow;

  @override
  DateTime call() => now;
}