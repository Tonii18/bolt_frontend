// ignore_for_file: unused_local_variable, unnecessary_new

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/services/user_service.dart';
import 'package:bolt_frontend/views/user_role/project_info.dart';
import 'package:bolt_frontend/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectsScreen> {
  late Future<List<Project>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = _loadProjectsData();
  }

  Future<List<Project>> _loadProjectsData() async {
    final users = await UserService().getAllUsers();
    final currentUser = await UserService().getCurrentUser();

    final user = users.firstWhere(
      (u) => u['email'] == currentUser['email'],
      orElse: () => throw Exception('Usuario no encontrado'),
    );

    final String userId = user['id'].toString();

    return ProjectService.getProjectsByUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    // Set scales

    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(116, 105, 147, 1),
        Color.fromRGBO(113, 150, 156, 1),
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    DateTime now = new DateTime.now();

    List<String> days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];

    List<String> months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    String dayWeek = days[now.weekday - 1];

    String month = months[now.month - 1];

    String finalDate = "$dayWeek, ${now.day} de $month";

    // Code

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 30,
          horizontal: scale * 30,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    'Bienvenido a Bolt',
                    style: TextStyle(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    finalDate,
                    style: TextStyle(
                      fontSize: scale * 15,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Mis proyectos',
                    style: TextStyle(
                      fontSize: scale * 20,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 30),

              _buildProjectsList(scale, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsList(double scale, double width) {
    return FutureBuilder<List<Project>>(
      future: _projects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final projects = snapshot.data ?? [];

        if (projects.isEmpty) {
          return Text('No projects found');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return _buildProjectItem(project, scale, width);
          },
        );
      },
    );
  }

  Widget _buildProjectItem(Project project, double scale, double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: scale * 5),
      decoration: BoxDecoration(
        color: AppColors.fabBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectInfo(project: project),
            ),
          );
        },
        leading: Icon(Icons.dashboard_rounded),
        title: Text(project.name),
        subtitle: Text(project.description),
      ),
    );
  }
}
