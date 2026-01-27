// ignore_for_file: unused_local_variable

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {

    // Set scales

    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);
    
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Proyectos'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
      ],
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.lightBlack,
      unselectedItemColor: AppColors.darkGrey,
      iconSize: scale * 35,

      // Change to true for hide labels
      
      showSelectedLabels: true,
      showUnselectedLabels: true,

      // Controls the current page

      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}