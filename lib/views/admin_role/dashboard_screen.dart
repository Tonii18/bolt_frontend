// ignore_for_file: unnecessary_new, use_build_context_synchronously

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/views/admin_role/create_project.dart';
import 'package:bolt_frontend/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Project>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = ProjectService.getAllProjects();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 30 * scale,
          vertical: 30 * scale,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    'Comienza un nuevo proyecto',
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 30),

              CustomFloatingActionButton(
                scale: scale,
                width: width,
                screen: CreateProject(),
                text: 'Empezar proyecto',
                icon: Icons.add,
              ),

              SizedBox(height: scale * 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    'Proyectos existentes',
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 30),

              // Projects list view
              FutureBuilder<List<Project>>(
                future: _projects,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No projects found');
                  } else {
                    final projectList = snapshot.data!;
                    if (projectList.isEmpty) {
                      return Text('No projects available');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        final project = projectList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: scale * 5),
                          decoration: BoxDecoration(
                            color: AppColors.fabBackground,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.dashboard_rounded,
                              color: AppColors.lightBlack,
                            ),
                            title: Text(project.name),
                            subtitle: Text(project.description),
                            trailing: IconButton(
                              icon: Icon(Icons.more_horiz_rounded),
                              color: AppColors.lightBlack,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: scale * 300,

                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              project.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.lightBlack,
                                                fontSize: scale * 20,
                                              ),
                                            ),

                                            SizedBox(height: scale * 5),

                                            Text(
                                              project.description,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                color: AppColors.lightBlack,
                                                fontSize: scale * 15,
                                              ),
                                            ),

                                            SizedBox(height: scale * 30),

                                            SizedBox(
                                              width: width * 0.8,
                                              child: TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: AppColors.lightBlack,
                                                ),
                                                label: Text('Editar proyecto'),
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.fabBackground,
                                                  foregroundColor:
                                                      AppColors.lightBlack,
                                                  shape: ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          30,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: scale * 5),

                                            SizedBox(
                                              width: width * 0.8,
                                              child: TextButton.icon(
                                                onPressed: () async {
                                                  delete(project);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: AppColors.red,
                                                ),
                                                label: Text(
                                                  'Eliminar proyecto',
                                                ),
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.fabBackground,
                                                  foregroundColor:
                                                      AppColors.red,
                                                  shape: ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          30,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delete(Project project) async {
    await ProjectService.deleteProject(project);

    Navigator.pop(context);

    setState(() {
      _projects = ProjectService.getAllProjects();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Proyecto eliminado correctamente')));
  }
}
