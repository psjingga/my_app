import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/profile.dart';
import 'package:my_app_new/shared_widget/custom_dialog..dart';

class homePage extends StatefulWidget {
  String? email;
  homePage({super.key, this.email});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HOMEPAGE'),
            SizedBox(
              height: 10,
            ),
            Text(
              'anda login menggunakan emaill : ${widget.email} ',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var name = 'Panji';
                    var age = '29';
                    context.goNamed(
                      'profile',
                      pathParameters: {
                        'nama': name,
                        'age': age,
                        'email': widget.email!,
                      },
                    );
                  },
                  child: Text(
                    'Profile',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alertDialog(
                          deskripsi: 'Apakah anda yakin ingin keluar',
                          onTap: () {
                            context.goNamed('login');
                          },
                          textButton: 'Yakin.!',
                        );
                      },
                    );
                  },
                  child: Text(
                    'Logout',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
