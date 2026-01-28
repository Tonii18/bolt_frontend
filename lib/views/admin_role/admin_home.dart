import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/views/admin_role/dashboard_screen.dart';
import 'package:bolt_frontend/views/user_role/settings_screen.dart';
import 'package:bolt_frontend/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedIndex = 0;

  final List<Widget> widgetsOptions = [
    const DashboardScreen(),
    const SettingsScreen(),
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
