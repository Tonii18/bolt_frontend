// ignore_for_file: unnecessary_new, use_build_context_synchronously

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project.dart';
import 'package:bolt_frontend/models/project_edit.dart';
import 'package:bolt_frontend/services/project_service.dart';
import 'package:bolt_frontend/views/admin_role/create_project.dart';
import 'package:bolt_frontend/views/admin_role/edit_project.dart';
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

    DateTime now = DateTime.now();

    final days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];

    final months = [
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

    final finalDate =
        "${days[now.weekday - 1]}, ${now.day} de ${months[now.month - 1]}";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 30 * scale,
          vertical: 30 * scale,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(linearGradient, finalDate, scale),
              SizedBox(height: scale * 30),
              _buildCreateProjectSection(scale, width),
              SizedBox(height: scale * 30),
              _buildProjectsTitle(scale),
              SizedBox(height: scale * 30),
              _buildProjectsList(scale, width),
            ],
          ),
        ),
      ),
    );
  }

  /// ============================
  /// UI SECTIONS
  /// ============================

  Widget _buildHeader(
    Shader gradient,
    String date,
    double scale,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bienvenido a Bolt',
          style: TextStyle(
            foreground: Paint()..shader = gradient,
            fontSize: scale * 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: scale * 15,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateProjectSection(double scale, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comienza un nuevo proyecto',
          style: TextStyle(
            fontSize: scale * 20,
            fontWeight: FontWeight.w800,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: scale * 30),
        CustomFloatingActionButton(
          scale: scale,
          width: width,
          screen: CreateProject(),
          text: 'Empezar proyecto',
          icon: Icons.add,
        ),
      ],
    );
  }

  Widget _buildProjectsTitle(double scale) {
    return Text(
      'Proyectos existentes',
      style: TextStyle(
        fontSize: scale * 20,
        fontWeight: FontWeight.w800,
        color: AppColors.lightBlack,
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
        leading: Icon(Icons.dashboard_rounded),
        title: Text(project.name),
        subtitle: Text(project.description),
        trailing: IconButton(
          icon: Icon(Icons.more_horiz_rounded),
          onPressed: () => _openProjectOptions(project, scale, width),
        ),
      ),
    );
  }

  /// ============================
  /// ACTIONS
  /// ============================

  void _openProjectOptions(Project project, double scale, double width) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          height: scale * 300,
          padding: EdgeInsets.all(scale * 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                project.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: scale * 20,
                ),
              ),

              SizedBox(height: scale * 5),

              Text(
                project.description,
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: scale * 15,
                ),
              ),

              SizedBox(height: scale * 30),
              _actionButton(
                icon: Icons.edit,
                text: 'Editar proyecto',
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _openEditDialog(project);
                },
              ),
              SizedBox(height: scale * 10),
              _actionButton(
                icon: Icons.delete,
                text: 'Eliminar proyecto',
                color: AppColors.red,
                onPressed: () => delete(project),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    Color? color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(text),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.fabBackground,
          foregroundColor: AppColors.lightBlack,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30)
          )
        ),
      ),
    );
  }

  Future<void> _openEditDialog(Project project) async {
    final updatedProject = await showDialog<ProjectEdit>(
      context: context,
      builder: (_) => EditProject(
        project: ProjectEdit(
          id: project.id,
          name: project.name,
          description: project.description,
        ),
      ),
    );

    if (updatedProject != null) {
      await ProjectService.updateProject(updatedProject);
      setState(() {
        _projects = ProjectService.getAllProjects();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Proyecto actualizado correctamente')),
      );
    }
  }

  void delete(Project project) async {
    await ProjectService.deleteProject(project);

    Navigator.pop(context);

    setState(() {
      _projects = ProjectService.getAllProjects();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Proyecto eliminado correctamente')),
    );
  }
}
