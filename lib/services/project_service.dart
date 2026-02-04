// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/models/project_create.dart';
import 'package:bolt_frontend/models/project_edit.dart';
import 'package:bolt_frontend/models/user_project.dart';
import 'package:bolt_frontend/services/token_service.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  static const String url = "https://bolt-backend-c99u.onrender.com";

  static Future<List<Project>> getAllProjects() async {
    String endpoint = '/projects/allProjects';

    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Project.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load projects');
    }
  }

  static Future<bool> updateProject(ProjectEdit project) async {
    String id = project.id;
    String endpoint = '/projects/update/$id';

    final token = await TokenService.getToken();

    if(token == null){
      throw Exception('No token found');
    }

    final response = await http.put(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(project.toJson()),
    );

    if(response.statusCode == 200){
      return true;
    }else{
      print(response.statusCode);
      throw Exception('Failed to update project');
    }
  }

  static Future<bool> createProject(ProjectCreate project) async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.post(
      Uri.parse('$url/projects/createdProject'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(project.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to create project');
    }
  }

  static Future<bool> deleteProject(Project project) async {
    String? id = project.id;
    String endpoint = '/projects/delete/$id';

    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw Exception('No tienes permiso para eliminar proyectos');
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to delete project');
    }
  }

  // ------------ //
  // Functions related to user assignment to projects
  // ------------ //

  // GET USERS BY PROJECT

  static Future <List<UserProject>> getUsersByProject(String projectId) async {
    String endpoint = '/projects/$projectId/users';
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }
    );

    if(response.statusCode == 200){
      List data = json.decode(response.body);
      return data.map((e) => UserProject.fromJson(e)).toList();
    }else{
      print(response.statusCode);
      throw Exception('Failed to load users for this project');
    }
  }

  // ADD USER TO PROJECT

  static Future <void> addUserToProject(String projectId, String userId) async {
    String endpoint = '/projects/$projectId/users/$userId';
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }
    );

    if(response.statusCode == 200){
      print('User added succesfully');
    }else{
      print(response.statusCode);
      throw Exception('Failed to add users for this project');
    }
  }

  // DELETE USER FROM PROJECT

  static Future <void> deleteUserFromProject(String projectId, String userId) async {
    String endpoint = '/projects/$projectId/users/$userId';
    final token = await TokenService.getToken();

    final response = await http.delete(
      Uri.parse(url + endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }
    );

    if(response.statusCode == 204){
      print('User deleted succesfully');
    }else{
      print(response.statusCode);
      throw Exception('Failed to add users for this project');
    }
  }

}
