import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/network/send_api.dart';
import 'package:my_app_new/shared_widget/custom_dialog..dart';

import 'network/dio_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool checked = false;
  bool serviceStatus = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  bool mockLocation = false;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    print('service status = ${serviceStatus.toString()}');
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();
      print('permission = $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.whileInUse) {
          print('lokasi diizinkan');
          position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          long = position.longitude.toString();
          lat = position.latitude.toString();

          print('longitude = $long dan latitude = $lat ');
        } else if (permission == LocationPermission.denied) {
          print('lokasi tidak diizinkan');
        } else {
          print('$permission');
        }
      } else if (permission == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        long = position.longitude.toString();
        lat = position.latitude.toString();
        mockLocation = position.isMocked;

        print(
          'longitude = $long dan latitude = $lat dan mocklocation ${mockLocation.toString()}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/home.png',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Silahkan masuk dengan nomor telkomsel kamu.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "email@mail.com",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checked,
                      activeColor: Colors.red,
                      onChanged: (x) {
                        setState(
                          () {
                            checked = !checked;
                          },
                        );
                        print('checked');
                      },
                    ),
                    Flexible(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(
                          text: "Saya menyetujui ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Ini syarat');
                                },
                              text: 'syarat',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ', ',
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Ini ketentuan');
                                },
                              text: 'ketentuan',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ', dan ',
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Ini privasi');
                                },
                              text: 'privasi',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Telkomsel',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (checked) {
                      if (email.text == '' || password.text == '') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog(
                              deskripsi: 'Email atau Password masih kosong',
                              onTap: () {
                                context.goNamed(
                                  'homepage',
                                  pathParameters: {
                                    'email': "No Email",
                                  },
                                );
                              },
                              textButton: 'Email Password button',
                            );
                          },
                        );
                      } else {
                        print('masuk post');
                        sendApi().postUser(
                          context,
                          email.text,
                          password.text,
                          'xxxxxxxxx',
                        );
                      }
                      print(checked);
                    } else {
                      print('not checked');
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alertDialog(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            textButton: 'Ini Checkbox alert',
                            deskripsi:
                                'Harap ceklis syarat, ketentuan, dan privasi terlebih dahulu.',
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'MASUK',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[200],
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      20.0,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Atau masuk menggunakan',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(
                          140.0,
                          20.0,
                        ),
                        side: BorderSide(
                          color: Color(
                            0xFF3B5998,
                          ),
                          width: 2,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              4.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        print('tombol facebook');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/facebook.png',
                          ),
                          Text(
                            'facebook',
                            style: TextStyle(
                              color: Color(
                                0xFF3B5998,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(
                          140,
                          40,
                        ),
                        side: BorderSide(
                          color: Color(
                            0xFF1DA1F2,
                          ),
                          width: 2,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              4.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print('tombol twitter');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/twitter.png',
                          ),
                          Text(
                            'twitter',
                            style: TextStyle(
                              color: Color(
                                0xFF1DA1F2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
