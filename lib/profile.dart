import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class profilePage extends StatefulWidget {
  String? nama;
  String? age;
  String? email;

  profilePage({
    super.key,
    this.nama,
    this.age,
    this.email,
  });

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile ${widget.nama}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halaman Profile'),
            SizedBox(
              height: 10,
            ),
            Text('Nama :  ${widget.nama}'),
            SizedBox(
              height: 10,
            ),
            Text('Umur : ${widget.age} Tahun'),
            SizedBox(
              height: 10,
            ),
            Text('Email : ${widget.email}'),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(
                  'homepage',
                  pathParameters: {
                    'email': widget.email!,
                  },
                );
              },
              child: Text(
                'Back',
              ),
            )
          ],
        ),
      ),
    );
  }
}
