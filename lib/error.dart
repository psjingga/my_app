import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class errorPage extends StatefulWidget {
  const errorPage({super.key});

  @override
  State<errorPage> createState() => _errorPageState();
}

class _errorPageState extends State<errorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page Not Found.!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text(
                'Back To Home',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
