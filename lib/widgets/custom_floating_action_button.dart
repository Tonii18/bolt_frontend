import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {

  const CustomFloatingActionButton({
    super.key,
    required this.scale,
    required this.width,
    required this.screen,
    required this.text, required this.icon, this.onReturn,
  });

  final double scale;
  final double width;
  final Widget screen;
  final String text;
  final IconData icon;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.fabBackground,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
        if (onReturn != null) onReturn!();
      },
      icon: Icon(icon, size: scale * 30, color: AppColors.lightBlack),

      elevation: 0,

      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),

      label: Text(
        text,
        style: TextStyle(
          fontSize: scale * 18,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlack,
        ),
      ),

      extendedPadding: EdgeInsets.symmetric(
        horizontal: width * 0.25,
        vertical: scale * 15,
      ),
    );
  }
}