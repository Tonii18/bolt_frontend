// ignore_for_file: unused_field

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/models/task_admin.dart';
import 'package:bolt_frontend/models/user_project.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/services/task_service.dart';
import 'package:bolt_frontend/views/admin_role/list_user_project.dart';
import 'package:bolt_frontend/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class ProjectInfo extends StatefulWidget {
  final Project project;

  const ProjectInfo({super.key, required this.project});

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  late Future<List<UserProject>> _projectUsers;
  late Future<List<TaskAdmin>> _projectTasks;

  @override
  void initState() {
    super.initState();
    _projectUsers = ProjectService.getUsersByProject(widget.project.id);
    _projectTasks = TaskService.getTAsksByProject(widget.project.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 30,
          horizontal: scale * 30,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.lightBlack),
                  ),
                  Text(
                    widget.project.name,
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 1),

              Divider(color: AppColors.lightGrey),

              SizedBox(height: scale * 15),

              Text(
                'Participantes',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: scale * 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: scale * 15),

              // Future builder for showing users
              FutureBuilder<List<UserProject>>(
                future: _projectUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error al cargar usuarios');
                  }

                  final users = snapshot.data!;

                  if (users.isEmpty) {
                    return Text(
                      'Este proyecto no tiene participantes',
                      style: TextStyle(color: AppColors.darkGrey),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppColors.blueWater, AppColors.purple],
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            // child: Text(
                            //   user.name[0].toUpperCase(),
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            child: Icon(
                              Icons.account_circle,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: IconButton(
                          onPressed: () {
                            ProjectService.deleteUserFromProject(
                              widget.project.id,
                              user.id,
                            );

                            setState(() {
                              _projectUsers = ProjectService.getUsersByProject(
                                widget.project.id,
                              );
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Usuario eliminado correctamente',
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.red,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // End of future builder
              SizedBox(height: scale * 15),

              CustomFloatingActionButton(
                scale: scale,
                width: width,
                text: 'Añadir participantes',
                icon: Icons.add,
                screen: ListUserProject(projectId: widget.project.id),
                onReturn: () {
                  setState(() {
                    _projectUsers = ProjectService.getUsersByProject(
                      widget.project.id,
                    );
                  });
                },
              ),

              SizedBox(height: scale * 15),

              Text(
                'Tareas del proyecto',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: scale * 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: scale * 15),

              // --------- //
              // FUTURE BUILDER FOR SHOWING TASKS
              // --------- //

              // Future builder for showing users
              FutureBuilder<List<TaskAdmin>>(
                future: _projectTasks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error al cargar tareas');
                  }

                  final tasks = snapshot.data!;

                  if (tasks.isEmpty) {
                    return Text(
                      'Este proyecto no tiene tareas',
                      style: TextStyle(color: AppColors.darkGrey),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return Container(
                        padding: EdgeInsets.symmetric(vertical: scale * 5, horizontal: scale * 5),
                        margin: EdgeInsets.symmetric(vertical: scale * 5),
                        decoration: BoxDecoration(
                          color: AppColors.fabBackground,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.lightBlack,
                            child: Icon(
                              Icons.add_task_rounded,
                              color: AppColors.white,
                            ),
                          ),
                          title: Text(task.title),
                          //subtitle: Text(task.description),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
