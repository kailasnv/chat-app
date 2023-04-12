import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/widgets_common/smooth_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets_common/custom_textfeild.dart';
import '../widgets_common/gradient_back_gnd.dart';
import '../widgets_common/logo_tile.dart';

class SignUserInOrOut extends StatelessWidget {
  SignUserInOrOut({super.key});

  // controllers for email & passwords
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ValueNotifier<bool> isSignInNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        getColors: [
          Colors.grey.shade100,
          Colors.deepPurple.shade200,
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // some intro texts.....
              const Padding(
                padding: EdgeInsets.only(top: 75, bottom: 15),
                child: Text(
                  "Hello Again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 33,
                  ),
                ),
              ),
              // greetings message ....
              const Padding(
                padding: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                child: Text(
                  "Welcome back you've been missed!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              // just a  animation above the textfeild
              Lottie.asset(
                "assets/animations/chatting.json",
                width: 180,
                fit: BoxFit.cover,
              ),
              /* 
                  Textfiels
              */
              CustomTextfield(
                controller: _emailController,
                hintText: "@email",
                isObscureText: false,
              ),
              const SizedBox(height: 15),
              CustomTextfield(
                controller: _passwordController,
                hintText: "password",
                isObscureText: true,
              ),

              // forgot password section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: Text("Forgot Password"),
                  ),
                ],
              ),

              // S I G N  I N   B U T T O N
              GestureDetector(
                onTap: () {
                  /* 
              <<<<<<<<  login method pending >>>>>>>>
                   */
                },
                child: const SmoothButton(
                  buttonWidth: 300,
                  buttonTitle: "Sign In",
                  buttonColor: Colors.black,
                  titleColor: Colors.white,
                ),
              ),

              /*
               or continue with , some other login options
              */
              kHeight,
              Divider(thickness: 0.7, color: Colors.white10.withOpacity(0.5)),
              const Text("or continue with"),

              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LogoTile(logoPath: "assets/images/google-logo.png"),
                  kWidth,
                  LogoTile(logoPath: "assets/images/apple-logo.png"),
                ],
              ),
              // Register new account - toggle to  S I G N   U P   page
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do not have an Account ? "),
                  GestureDetector(
                    onTap: () {
                      isSignInNotifier.value = !isSignInNotifier.value;
                      print(isSignInNotifier.value.toString());
                    },
                    child: const Text(
                      " Sign Up .",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
