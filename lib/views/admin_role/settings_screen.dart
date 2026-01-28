// ignore_for_file: unused_local_variable

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Ajustes de Administrador',
                style: TextStyle(
                  fontSize: scale * 22,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: scale * 10),
              Divider(color: AppColors.lightGrey),
              SizedBox(height: scale * 10),

              Text(
                'Datos personales',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: scale * 22,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: scale * 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Correo electrónico',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    'correo@prueba',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Nombre completo',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  
                ],
              ),

              SizedBox(height: scale * 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Teléfono',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  
                ],
              ),

              SizedBox(height: scale * 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Rol',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w400
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
