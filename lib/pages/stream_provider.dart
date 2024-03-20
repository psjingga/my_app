import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/provider/weather.dart';

class StreamProviderView extends ConsumerWidget {
  const StreamProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Provider'),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              'homepage',
              pathParameters: {
                'email': 'No Email',
              },
            );
            // ref.invalidate(weatherStreamProvider);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer(
              builder: (context, ref, child) =>
                  ref.watch(weatherStreamProvider).when(
                data: (data) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(data.path),
                  );
                },
                error: (error, stackTrace) {
                  return Text('Terjadi kesalahan ${error.toString()}');
                },
                loading: () {
                  return Text('Loading..');
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     ref.invalidate(weatherStreamProvider);
            //   },
            //   child: Text(
            //     'Reset',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
