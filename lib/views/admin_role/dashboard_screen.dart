// ignore_for_file: unnecessary_new

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/views/admin_role/create_project.dart';
import 'package:bolt_frontend/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

              CustomFloatingActionButton(scale: scale, width: width, screen: CreateProject(), text: 'Empezar proyecto', icon: Icons.add),

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
            ],
          ),
        ),
      ),
    );
  }
}