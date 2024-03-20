import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/shared_widget/custom_dialog..dart';

import 'provider/greeting.dart';

class homePage extends ConsumerStatefulWidget {
  String? email;
  homePage({super.key, this.email});

  @override
  ConsumerState<homePage> createState() => _homePageState();
}

class _homePageState extends ConsumerState<homePage> {
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
            Consumer(
              builder: (context, ref, child) {
                final hello = ref.watch(helloProvider);
                return Text(
                  hello + ' ' + widget.email!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                );
              },
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
                        'name': name,
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
                    context.goNamed('homeNew');
                  },
                  child: Text(
                    'Home New',
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      250,
                      40,
                    ),
                  ),
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('future');
                  },
                  child: Text(
                    'Future Provider',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('stream');
                  },
                  child: Text(
                    'Stream Provider',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('user');
                  },
                  child: Text(
                    'User Provider',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
