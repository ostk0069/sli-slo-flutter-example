import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sli_slo/model/sentry_span_child_operation_type.dart';
import 'package:sli_slo/sli_slo_transaction.dart';
import 'package:sli_slo/sli_slo_transaction_holder.dart';

void main() async {
  await SentryFlutter.init((option) {
    option.dsn = 'test';
    option.tracesSampler = (samplingContext) {
      return 1.0;
    };
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter SLI/SLO Demo Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Future<void> _testTransaction({
    required SLISLOTransaction playgroundTestSLO,
    bool shouldThrow = false,
  }) async {
    try {
      playgroundTestSLO.start();
      const childOperationName = 'playground_test_child_web_view';
      playgroundTestSLO.startChild(
        operationName: childOperationName,
        operationType: SentrySpanChildOperationType.webView,
      );
      playgroundTestSLO.setChildStatusAndFinish(
        operationName: childOperationName,
        spanStatus: shouldThrow
            ? const SpanStatus.unavailable()
            : const SpanStatus.ok(),
      );

      if (shouldThrow) {
        throw const FormatException('test format exception at transaction');
      }
    } catch (exception) {
      playgroundTestSLO.setStatusWhenNull(const SpanStatus.internalError());
    } finally {
      playgroundTestSLO.setStatusWhenNull(const SpanStatus.ok());
      playgroundTestSLO.finish();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playgroundTestSLO = ref.watch(sliSloTransactionHolderProvider).playgroundTest1;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async => _testTransaction(
                playgroundTestSLO: playgroundTestSLO,
              ),
              child: const Text('Measure Success Transaction'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async => _testTransaction(
                playgroundTestSLO: playgroundTestSLO,
                shouldThrow: true,
              ),
              child: const Text('Measure Failure Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
