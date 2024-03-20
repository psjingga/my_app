import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app_new/model/user_model.dart';
import 'package:my_app_new/network/send_api.dart';

var userProvider = Provider<sendApi>((ref) => sendApi());

var userDataProvider = FutureProvider.autoDispose<List<UserModel>>(
    (ref) => ref.watch(userProvider).getUsers());
