// ignore_for_file: unnecessary_new

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/views/admin_role/create_project.dart';
import 'package:bolt_frontend/widgets/custom_floating_action_button.dart';
import 'package:bolt_frontend/widgets/custom_listview_builder.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<dynamic>> _projects;

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
              FutureBuilder<List<dynamic>>(
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
                            title: Text(project['name'] ?? 'No Name'),
                            subtitle: Text(
                              project['description'] ?? 'No Description',
                            ),
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
                                              project['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.lightBlack,
                                                fontSize: scale * 20,
                                              ),
                                            ),

                                            SizedBox(height: scale * 5),

                                            Text(
                                              project['description'],
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
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _editProject(project);
                                                },
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
                                                onPressed: () async{
                                                  final confirm =  await showDialog<bool>(
                                                    context: context, 
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('Confirmar eliminación'),
                                                        content: Text('¿Estás seguro de que deseas eliminar este proyecto? Esta acción no se puede deshacer.'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.of(context).pop(false),
                                                            child: Text('Cancelar'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () => Navigator.of(context).pop(true),
                                                            child: Text('Eliminar', style: TextStyle(color: AppColors.red),),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  );
                                                  if(confirm == true){
                                                    try {
                                                      // TODO: implementar -> await ProjectService.deleteProject(project['id'].toString());
                                                      if (mounted) {
                                                        setState(() {
                                                          _projects = ProjectService.getAllProjects();
                                                        });
                                                      }
                                                    } catch (e) {
                                                      print('Error deleting project: $e');
                                                    }
                                                  }
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

  Future<void> _editProject(Map<String, dynamic> project) async {
    final TextEditingController namecontroller = TextEditingController(
      text: project['name'],
    );
    final TextEditingController descriptioncontroller = TextEditingController(
      text: project['description'],
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Proyecto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: 'Nombre del proyecto'),
              ),
              TextField(
                controller: descriptioncontroller,
                decoration: InputDecoration(
                  labelText: 'Descripción del proyecto',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final updatedProject = Project(
                  id: project['id'],
                  name: namecontroller.text,
                  description: descriptioncontroller.text,
                  creationDate: DateTime.parse(project['creationDate']),
                );

                try {
                  await ProjectService.updateProject(
                    project['id'].toString(),
                    updatedProject,
                  );
                  if (mounted) {
                    setState(() {
                      _projects = ProjectService.getAllProjects();
                    });
                  }
                } catch (e) {
                  print('Error updating project: $e');
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
