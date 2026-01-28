import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/user_register.dart';
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
                  fontSize: scale * 20,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: scale * 20),
              Divider(color: AppColors.darkGrey),
              SizedBox(height: scale * 20),

              Text(
                'Datos personales',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: scale * 17,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: scale * 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Correo electrónico',
                    style: TextStyle(
                      fontSize: scale * 12,
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
