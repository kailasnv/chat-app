import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isObscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
          ),
        ),
      ),
    );
  }
}
