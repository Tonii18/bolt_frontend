// ignore_for_file: unused_local_variable

import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/widgets/custom_elevated_button.dart';
import 'package:bolt_frontend/widgets/custom_floating_action_button.dart';
import 'package:bolt_frontend/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    List<Color> gradientColors = [AppColors.blueWater, AppColors.purple];

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale * 30,
          vertical: scale * 30,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.lightBlack),
                  ),
                  Text(
                    'Crea un nuevo proyecto',
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 1),

              Divider(color: AppColors.lightGrey),

              SizedBox(height: scale * 15),

              Text(
                'Datos del proyecto',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: scale * 20,
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: scale * 15),

              CustomFormField(
                width: width,
                text: 'Título del proyecto',
                textColor: AppColors.darkGrey,
                background: AppColors.mainGrey,
                iconColor: AppColors.darkGrey,
                focusedOutlinedBorder: Colors.transparent,
                isPassword: false,
                icon: Icons.edit,
              ),

              SizedBox(height: scale * 10),

              CustomFormField(
                width: width,
                text: 'Descripción',
                textColor: AppColors.darkGrey,
                background: AppColors.mainGrey,
                iconColor: AppColors.darkGrey,
                focusedOutlinedBorder: Colors.transparent,
                isPassword: false,
                icon: Icons.description,
              ),

              SizedBox(height: scale * 15),

              Text(
                'Participantes',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: scale * 20,
                ),
              ),

              SizedBox(height: scale * 15),

              Text(
                'Añade participantes a tu proyecto \npara que puedan colaborar. \nPuedes hacerlo ahora o más adelante',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w300,
                  fontSize: scale * 17,
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: scale * 15),

              CustomFloatingActionButton(
                scale: scale,
                width: width,
                screen: null,
                text: 'Añadir participantes',
                icon: Icons.add,
              ),

              SizedBox(height: scale * 250),

              SizedBox(
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30)
                    )
                  ),
                  child: CustomElevatedButton(
                    width: width,
                    height: 60,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    text: 'Crear proyecto',
                    textColor: AppColors.white,
                    fontSize: scale * 20,
                    fontWeight: FontWeight.w800,
                    onPressed: () {
                      
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
