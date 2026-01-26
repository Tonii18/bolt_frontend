import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    // Set scales

    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    // Code

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 20,
          horizontal: scale * 20,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Bienvenido a Bolt'),
                  Text('Martes, 27 de Enero'),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text('Mis proyectos'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
