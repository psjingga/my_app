import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/provider/weather.dart';

class FutureProviderView extends StatelessWidget {
  const FutureProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Provider'),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              'homepage',
              pathParameters: {
                'email': 'No Email',
              },
            );
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) =>
              ref.watch(weatherFutureProvider).when(
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
              return Text('Loading...');
            },
          ),
        ),
      ),
    );
  }
}
