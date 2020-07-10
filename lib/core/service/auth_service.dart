import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:login_view/core/model/user_request.dart';

const String _FIREBASE_AUTH_URL =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCZn6IS_t3eZGFdrKFs7YMAebLVEX8RR3I";

class AuthService {
  static Future<bool> postUser(UserRequest user) async {
    final userJson = json.encode(user.toJson());
    final response = await http.post(_FIREBASE_AUTH_URL, body: userJson);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }
}
