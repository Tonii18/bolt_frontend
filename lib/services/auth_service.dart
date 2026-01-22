// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bolt_frontend/models/user_register.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String url = 'http://192.168.1.134:8080';

  static Future<String?> register(UserRegister user) async {
    try {
      String endpoint = '/auth/register';

      final response = await http.post(
        Uri.parse(url + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        final body = response.body;
        return body.isNotEmpty ? body : 'Unknown error';
      }
    } catch (e) {
      return '$e: Cannot connect to the server';
    }
  }

  static Future<String?> login(String email, String password) async {

    String endpoint = '/auth/login';

    try {
      final response = await http.post(
        Uri.parse(url + endpoint),
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password
        }),
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final token = data['token'];

        return token;
      } else if(response.statusCode == 401){
        return 'Email or password incorrect';
      } else{
        return response.body.isNotEmpty ? response.body : 'Unknown error';
      }
    } catch (e) {
      return '$e Cannot connect to the server';
    }
  }
}
