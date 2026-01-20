import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Outfit',
        scaffoldBackgroundColor: AppColors.background
      ),
      home: LoginScreen(),
    );
  }
}
