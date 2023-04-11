import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/widgets_common/smooth_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets_common/custom_textfeild.dart';
import '../../widgets_common/gradient_back_gnd.dart';
import '../../widgets_common/logo_tile.dart';

class RegisterScreen extends StatelessWidget {
  final void Function()? togglePages;
  RegisterScreen({super.key, required this.togglePages});

  // controllers for email & passwords
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
              // some intro texts ....
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
              // greetings message .....
              const Padding(
                padding: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                child: Text(
                  "Lets create a new account for you .",
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
              kHeight,
              CustomTextfield(
                controller: _passwordController,
                hintText: "password",
                isObscureText: true,
              ),
              kHeight,
              CustomTextfield(
                controller: _confirmPasswordController,
                hintText: "confirm password",
                isObscureText: true,
              ),
              kHeight,

              // S I G N   U P   B U T T O N
              GestureDetector(
                onTap: () {
                  /* 
              <<<<<<<<  sign up method pending >>>>>>>>
                   */
                },
                child: const SmoothButton(
                  buttonWidth: 300,
                  buttonTitle: "Sign Up",
                  buttonColor: Colors.black,
                  titleColor: Colors.white,
                ),
              ),

              /*
               or continue with , some other login options ( google or apple )
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
              // already have an account  - toggle  to  S I G N  I N   page
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account ? "),
                  GestureDetector(
                    onTap: togglePages,
                    child: const Text(
                      " Log In .",
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
