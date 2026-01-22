import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color background;
  final Color iconColor;
  final Color focusedOutlinedBorder;
  final TextEditingController? textEditingController;
  final bool isPassword;
  final IconData icon;
  final FormFieldValidator? validator;

  const CustomFormField({
    super.key,
    required this.width,
    required this.text,
    required this.textColor,
    required this.background,
    required this.iconColor,
    required this.focusedOutlinedBorder,
    this.textEditingController,
    required this.isPassword,
    required this.icon, 
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        obscureText: widget.isPassword,

        validator: widget.validator,

        controller: widget.textEditingController,

        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          prefixIconColor: widget.iconColor,
          filled: true,
          fillColor: widget.background,

          hintText: widget.text,
          hintStyle: TextStyle(
            color: widget.textColor,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.focusedOutlinedBorder),
          ),
        ),
      ),
    );
  }
}
