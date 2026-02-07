// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bolt_frontend/models/task_admin.dart';
import 'package:bolt_frontend/services/token_service.dart';
import 'package:http/http.dart' as http;

class TaskService {
  static const String url = "https://bolt-backend-c99u.onrender.com";

  static Future<List<TaskAdmin>> getTAsksByProject(String projectId) async {
    String endpoint = '/tasks/$projectId/allTasks';
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List data = json.decode(response.body);
      return data.map((e) => TaskAdmin.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load users for this project');
    }
  }

  static Future<void> taskStatusChange(String taskId, String newState) async {
    String endpoint = '/tasks/updateState/$taskId';
    final token = await TokenService.getToken();

    final response = await http.put(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'state': newState}),
    );

    if (response.statusCode == 200) {
      print('Task state updated successfully');
    } else {
      print(response.statusCode);
      print('Status Code: ${response.statusCode}');
      print(
        'Response Body: ${response.body}',
      ); // ESTO TE DIRÁ POR QUÉ SPRING TE DA 403
      throw Exception('Failed to update task state');
    }
  }
}
