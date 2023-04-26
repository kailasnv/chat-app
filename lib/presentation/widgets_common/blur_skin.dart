import 'dart:ui';

import 'package:flutter/material.dart';

class BlurSkin extends StatelessWidget {
  final Widget child;
  const BlurSkin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ]),
              // border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
