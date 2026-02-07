import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/views/user_role/projects_screen.dart';
import 'package:bolt_frontend/views/user_role/settings_screen.dart';
import 'package:bolt_frontend/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  int selectedIndex = 0;

  final List<Widget> widgetsOptions = [
    ProjectsScreen(),
    SettingsScreen(),
  ];

  void onNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: widgetsOptions[selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavTapped,
      ),
    );
  }
}