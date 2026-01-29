// ignore_for_file: unused_local_variable, unused_field

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/services/auth_service.dart';
import 'package:bolt_frontend/services/user_service.dart';
import 'package:bolt_frontend/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    final userData = await _userService.getCurrentUser();

    setState(() {
      _userData = userData;
      _isLoading = false;
    });
  }

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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_userData?['email'] ?? ''}',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_userData?['fullName'] ?? ''}',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_userData?['phone'] ?? ''}',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_userData?['role'] ?? ''}',
                    style: TextStyle(
                      fontSize: scale * 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 10),
              Divider(color: AppColors.lightGrey),
              SizedBox(height: scale * 10),

              Text(
                'Acciones',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: scale * 22,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: scale * 20),

              FloatingActionButton.extended(
                backgroundColor: AppColors.backgroundRed,
                onPressed: () {
                  AuthService.logout();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.power_settings_new_sharp, size: scale * 30, color: AppColors.red),

                elevation: 0,

                shape: ContinuousRectangleBorder(
                  side: BorderSide(
                    color: AppColors.red
                  ),
                  borderRadius: BorderRadiusGeometry.circular(30),
                ),

                label: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontSize: scale * 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.red,
                  ),
                ),

                extendedPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.25,
                  vertical: scale * 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
