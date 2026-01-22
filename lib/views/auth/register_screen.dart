// ignore_for_file: use_build_context_synchronously

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/models/user_register.dart';
import 'package:bolt_frontend/services/auth_service.dart';
import 'package:bolt_frontend/widgets/custom_elevated_button.dart';
import 'package:bolt_frontend/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form validation

  final _formChecked = GlobalKey<FormState>();

  // Text controllers

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            key: _formChecked,
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

                    SizedBox(height: scale * 150),

                    CustomFormField(
                      width: width,
                      text: 'Nombre de usuario',
                      textColor: AppColors.darkGrey,
                      background: AppColors.lightGrey,
                      iconColor: AppColors.lightBlack,
                      focusedOutlinedBorder: AppColors.lightBlack,
                      isPassword: false,
                      icon: Icons.account_circle,
                      textEditingController: fullnameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nombre de usuario es obligatorio';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: scale * 10),

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
                      text: 'Número de teléfono',
                      textColor: AppColors.darkGrey,
                      background: AppColors.lightGrey,
                      iconColor: AppColors.lightBlack,
                      focusedOutlinedBorder: AppColors.lightBlack,
                      isPassword: false,
                      icon: Icons.phone,
                      textEditingController: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Teléfono es obligatorio';
                        }
                        if (value != null && value.isNotEmpty) {
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Teléfono debe contener solo números';
                          }
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
                      text: 'Registrarme',
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
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            fontSize: scale * 16,
                            fontWeight: FontWeight.w100,
                            color: AppColors.lightBlack,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Inicia sesion',
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
    if (_formChecked.currentState!.validate()) {
      String fullname = fullnameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String password = passwordController.text;

      UserRegister newUser = UserRegister(
        fullname: fullname,
        email: email,
        phone: phone,
        password: password,
      );

      final message = await AuthService.register(newUser);

      if (message == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso')),
      );
      // Navigate to Log in screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    } else {
      // ignore: avoid_print
      print('Invalid form');
    }
  }
}
