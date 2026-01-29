// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bolt_frontend/models/user_register.dart';
import 'package:bolt_frontend/services/token_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String url =
      'http://172.20.10.4:8081'; //http://192.168.50.36:8081"; //"http://10.0.2.2:8081";  //'http://192.168.1.134:8081'; //http://10.10.6.143:8081

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
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        await TokenService.saveToken(token);

        return token;
      } else if (response.statusCode == 401) {
        return 'Email or password incorrect';
      } else {
        return response.body.isNotEmpty ? response.body : 'Unknown error';
      }
    } catch (e) {
      return '$e Cannot connect to the server';
    }
  }
}
