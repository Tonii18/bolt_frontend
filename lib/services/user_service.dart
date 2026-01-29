import 'dart:convert';

import 'package:bolt_frontend/services/token_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String url = "https://bolt-backend-c99u.onrender.com";

  Future<Map<String, dynamic>> getCurrentUser() async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$url/users/currentUser'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      await TokenService.deleteToken();
      throw Exception('Unauthorized: Invalid token');
    } else {
      throw Exception('Failed to load current user');
    }
  }
}
