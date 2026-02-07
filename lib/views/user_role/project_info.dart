import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/models/task_admin.dart';
import 'package:bolt_frontend/models/user_project.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/services/task_service.dart';
import 'package:bolt_frontend/views/user_role/add_task.dart';
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
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  Text(
                    widget.project.name,
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightBlack,
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
                  fontSize: scale * 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.lightBlack,
                ),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: scale * 15),

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

                  return SizedBox(
                    height: 150,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.blueWater,
                                      AppColors.purple,
                                    ],
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: Icon(
                                    Icons.account_circle,
                                    color: AppColors.purple,
                                  ),
                                ),
                              ),
                              title: Text(user.name),
                              subtitle: Text(user.email),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: scale * 15),

              Text(
                'Tareas',
                style: TextStyle(
                  fontSize: scale * 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.lightBlack,
                ),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: scale * 15),

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
                        padding: EdgeInsets.symmetric(
                          vertical: scale * 5,
                          horizontal: scale * 5,
                        ),
                        margin: EdgeInsets.symmetric(vertical: scale * 5),
                        decoration: BoxDecoration(
                          color: AppColors.fabBackground,
                          borderRadius: BorderRadius.circular(10),
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
                          trailing: IconButton(
                            onPressed: () {}, 
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: scale * 15),

              CustomFloatingActionButton(scale: scale, width: width, screen: AddTask(), text: "Añadir tareas", icon: Icons.add_task)
            ],
          ),
        ),
      ),
    );
  }
}
