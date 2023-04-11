import 'package:chat_app/presentation/intro_page/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat-App",
      theme: ThemeData(),
      home: const IntroScreen(),
    );
  }
}
