// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/models/project_create.dart';
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

  // static Future<void> updateProject(String projectId, Project updatedProject) async {
  //   String endpoint = '/projects/update/$projectId';

  //   final token = await TokenService.getToken();

  //   if(token == null){
  //     throw Exception('No token found');
  //   }

  //   final response = await http.put(
  //     Uri.parse(url + endpoint),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(updatedProject.toJson()),
  //   );

  //   if(response.statusCode == 200){
  //     print('Project updated successfully');
  //   }else{
  //     print(response.statusCode);
  //     throw Exception('Failed to update project');
  //   }
  // }

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
}
