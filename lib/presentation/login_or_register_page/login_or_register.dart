import 'package:chat_app/presentation/login_or_register_page/login_page/login_screen.dart';
import 'package:chat_app/presentation/login_or_register_page/register_page/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  /*
     This page controlls the togglling between login and register pages 
   */
  // initially shows the login page
  bool isLoggedIn = true;
  // toggle pages method
  void togglePages() {
    setState(() {
      isLoggedIn = !isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return LoginScreen(togglePages: togglePages);
    } else {
      return RegisterScreen(togglePages: togglePages);
    }
  }
}
