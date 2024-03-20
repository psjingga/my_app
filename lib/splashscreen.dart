import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/login.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashhscreen();
  }

  splashhscreen() async {
    var durasi = const Duration(seconds: 3);

    return Timer(
      durasi,
      () {
        context.go('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 255, 17, 0),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
