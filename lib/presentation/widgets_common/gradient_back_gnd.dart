import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GradientBackground extends StatelessWidget {
  final List<Color> getColors;
  final Widget child;
  const GradientBackground(
      {super.key, required this.getColors, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: getColors,
        ),
      ),
      child: child,
    );
  }
}
