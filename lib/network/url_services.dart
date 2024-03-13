import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlService {
  static final baseUrl = dotenv.env['PROD'] == 'true'
      ? "https://reqres.in/"
      : "https://reqres.in/";

  static final getUsers = 'api/users';
  static final login = 'api/login';
}
