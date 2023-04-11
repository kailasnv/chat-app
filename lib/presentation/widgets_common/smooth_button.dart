import 'package:flutter/material.dart';

class SmoothButton extends StatelessWidget {
  final double buttonWidth;
  final String buttonTitle;
  final Color titleColor;
  final Color buttonColor;

  const SmoothButton({
    super.key,
    required this.buttonWidth,
    required this.buttonTitle,
    required this.buttonColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: buttonWidth,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
