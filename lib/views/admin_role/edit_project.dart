// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/project_edit.dart';
import 'package:flutter/material.dart';

class EditProject extends StatefulWidget {
  final ProjectEdit project;

  const EditProject({super.key, required this.project});

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.project.name);
    descriptionController = TextEditingController(
      text: widget.project.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar proyecto'),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(50)
      ),
      surfaceTintColor: AppColors.white,
      content: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del proyecto',
                prefixIcon: Icon(Icons.edit)
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                prefixIcon: Icon(Icons.description)
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.red
          ),
        ),
        ElevatedButton(
          onPressed: _save, 
          child: Text('Guardar'),
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.lightBlack
          ),
        ),
      ],
    );
  }

  void _save() {
    if (nameController.text.trim().isEmpty) return;

    final updatedProject = ProjectEdit(
      id: widget.project.id,
      name: nameController.text,
      description: descriptionController.text,
    );

    Navigator.pop(context, updatedProject);
  }
}
