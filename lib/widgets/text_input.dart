import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';

class TextInputField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isObscure;
  const TextInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: buttonColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
