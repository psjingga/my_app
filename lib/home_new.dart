import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'provider/counter.dart';
import 'provider/greeting.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a builder widget that allows you to read providers.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count'),
            SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                final name = ref.read(helloProvider);
                return Text(name);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(
                  'homepage',
                  pathParameters: {
                    'email': 'No Email',
                  },
                );
              },
              child: Text(
                'Back Home',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(counterProvider);
              },
              child: Text(
                'Reset',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
