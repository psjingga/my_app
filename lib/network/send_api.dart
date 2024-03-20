import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/model/user_model.dart';

import 'dio_services.dart';
import 'url_services.dart';

var token = 'bearer klaskdlasd';

final dio = Dio();

class sendApi {
  getData(int page, BuildContext context) async {
    await dioService().get(
      path: UrlService.getUsers,
      queryParameters: {
        'page': 2,
      },
      onSuccess: (content) {
        print('sukses');
        print(content);
      },
      onError: (onError) {
        print('error');
        print(onError);
      },
      headers: {
        "Authorization": token,
      },
    );
  }

  postUser(
    BuildContext context,
    String email,
    String password,
    String uid,
  ) async {
    await dioService().post(
      headers: {
        "Authorization": "Bearer token",
        "Content-type": "application/json",
      },
      path: UrlService.login,
      onSuccess: (onSuccess) {
        print('sukses');
        print(onSuccess);
        // print('id user = ${onSuccess['id']} ');
        context.goNamed(
          'homepage',
          pathParameters: {
            'email': email,
          },
        );
      },
      onError: (onError) {
        print('gagal');
        print(onError);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Padding(
                padding: EdgeInsets.all(
                  15.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      onError['error'],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      body: {
        "email": email,
        "password": password,
      },
    );
  }

  getHttp() async {
    dio.interceptors.add(LogInterceptor());
    final response = await dio.post(
      'https://dart.dev',
      data: {
        'username': 'panji',
        'password': '123456',
      },
      options: Options(headers: {'Authorization': 'Bearer tokken'}),
    );
    print(response);
  }

  Future<List<UserModel>> getUsers() async {
    Response response =
        await dio.get('https://reqres.in/api/users?page=1&per_page=12');

    if (response.statusCode == 200) {
      final List result = response.data['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
