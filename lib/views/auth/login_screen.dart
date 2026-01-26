// ignore_for_file: use_build_context_synchronously, dead_code, avoid_print

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/core/secure_storage.dart';
import 'package:bolt_frontend/services/auth_service.dart';
import 'package:bolt_frontend/views/admin_role/admin_home.dart';
import 'package:bolt_frontend/views/auth/register_screen.dart';
import 'package:bolt_frontend/views/user_role/user_home.dart';
import 'package:bolt_frontend/widgets/custom_elevated_button.dart';
import 'package:bolt_frontend/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set scales

    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    // Code

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: SvgPicture.asset(
              'assets/images/backgorund.svg',
              fit: BoxFit.cover,
            ),
          ),

          Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: scale * 35,
                  horizontal: scale * 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: scale * 60),

                    SvgPicture.asset(
                      'assets/images/icon.svg',
                      width: scale * 85,
                      height: scale * 85,
                    ),

                    Text(
                      'Bolt',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: scale * 30,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: scale * 300),

                    CustomFormField(
                      width: width,
                      text: 'Correo electrónico',
                      textColor: AppColors.darkGrey,
                      background: AppColors.lightGrey,
                      iconColor: AppColors.lightBlack,
                      focusedOutlinedBorder: AppColors.lightBlack,
                      isPassword: false,
                      icon: Icons.email,
                      textEditingController: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email es obligatorio';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: scale * 10),

                    CustomFormField(
                      width: width,
                      text: 'Contraseña',
                      textColor: AppColors.darkGrey,
                      background: AppColors.lightGrey,
                      iconColor: AppColors.lightBlack,
                      focusedOutlinedBorder: AppColors.lightBlack,
                      isPassword: true,
                      icon: Icons.password,
                      textEditingController: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contraseña es obligatoria';
                        }
                        if (value.length < 8) {
                          return 'Longitud mínima de 8 caracteres';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: scale * 30),

                    CustomElevatedButton(
                      width: width,
                      height: 55,
                      backgroundColor: AppColors.lightBlack,
                      borderColor: AppColors.lightBlack,
                      borderRadius: 30,
                      text: 'Iniciar sesión',
                      textColor: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      onPressed: () {
                        submit();
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Aún no tienes cuenta?',
                          style: TextStyle(
                            fontSize: scale * 16,
                            fontWeight: FontWeight.w100,
                            color: AppColors.lightBlack,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Regístrate',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: scale * 16,
                              color: AppColors.lightBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      final result = await AuthService.login(email, password);

      if (result!.startsWith('eyJ')) {
        await SecureStorage.saveToken(result);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logged succesfully!')));

        // Get information about whether the user role is USER or ADMIN

        String token = await SecureStorage.getToken() as String;
        String role = SecureStorage.getRoleFromToken(token);

        print(token);
        print(role);

        if (role == 'ROLE_USER') {
          print(role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserHome()),
          );
        } else if (role == 'ROLE_ADMIN') {
          print(role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }
}
