import 'package:flutter/material.dart';

class LogoTile extends StatelessWidget {
  final String logoPath;
  const LogoTile({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 65,
        width: 90,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(logoPath),
        ),
      ),
    );
  }
}
