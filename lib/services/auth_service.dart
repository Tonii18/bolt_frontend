import 'dart:convert';

import 'package:bolt_frontend/models/user_register.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String url = 'http://localhost:3000';

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
        // We get the response from backend
        final body = response.body;
        return body.isNotEmpty ? body : 'Unknown error';
      }
    } catch (e) {
      return 'Cannot connect to the server';
    }
  }
}
