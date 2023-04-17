import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/widgets_common/smooth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets_common/custom_textfeild.dart';
import '../widgets_common/gradient_back_gnd.dart';
import '../widgets_common/logo_tile.dart';

// ignore: must_be_immutable
class SignUserScreen extends StatefulWidget {
  const SignUserScreen({super.key});

  @override
  State<SignUserScreen> createState() => _SignUserScreenState();
}

class _SignUserScreenState extends State<SignUserScreen> {
  //
  // controllers for email & passwords
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // this notifier used to manage the sign in & sign up feature
  ValueNotifier<bool> isSignInNotifier = ValueNotifier(true);

  // some greeting messages for the user
  final String greetingSignIn = "Welcome back you've been missed!";
  final String greetingSignUp = "Let's create a new account for you .";

  // Sign  user Methods
  void signInMethod() async {
    try {
      showLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showErrorMessage(context, e.code);
    }
  }

  void signUpMethod() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        showLoading();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        showErrorMessage(context, "password does not match !");
      }
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showErrorMessage(context, e.code);
    }
  }

  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black)),
        margin: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
              // greetings message .... - changes according to the value notifier -
              Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
                child: ValueListenableBuilder(
                  valueListenable: isSignInNotifier,
                  builder: (context, value, child) {
                    return Text(
                      isSignInNotifier.value ? greetingSignIn : greetingSignUp,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    );
                  },
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
              const SizedBox(height: 10),
              CustomTextfield(
                controller: _passwordController,
                hintText: "password",
                isObscureText: true,
              ),
              // creates either "conform password" feild or "Forgot password" , according to value notifier
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ValueListenableBuilder(
                  valueListenable: isSignInNotifier,
                  builder: (context, value, child) {
                    if (isSignInNotifier.value) {
                      return Row(
                        //show forgot password section
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text("Forgot Password"),
                          ),
                        ],
                      );
                    } else {
                      // show confirm password feild
                      return CustomTextfield(
                        controller: _confirmPasswordController,
                        hintText: "confirm password",
                        isObscureText: true,
                      );
                    }
                  },
                ),
              ),

              // Sign User -  Buttons
              ValueListenableBuilder(
                valueListenable: isSignInNotifier,
                builder: (context, value, child) {
                  if (isSignInNotifier.value) {
                    // S I G N  I N   B U T T O N
                    return GestureDetector(
                      onTap: () {
                        signInMethod();
                      },
                      child: const SmoothButton(
                        buttonWidth: 300,
                        buttonTitle: "Sign In",
                        buttonColor: Colors.black,
                        titleColor: Colors.white,
                      ),
                    );
                  } else {
                    // S I G N  U P   B U T T O N
                    return GestureDetector(
                      onTap: () {
                        signUpMethod();
                      },
                      child: const SmoothButton(
                        buttonWidth: 300,
                        buttonTitle: "Sign Up",
                        buttonColor: Colors.black,
                        titleColor: Colors.white,
                      ),
                    );
                  }
                },
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

              /*
                 Help Text section - rebuilds to  sign in & sign up   sections
              */
              kHeight,
              ValueListenableBuilder(
                valueListenable: isSignInNotifier,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isSignInNotifier.value
                            ? "Do not have an Account ? "
                            : "Already have an account ? then ",
                      ),
                      GestureDetector(
                        onTap: () {
                          isSignInNotifier.value = !isSignInNotifier.value;
                          _emailController.text = "";
                          _passwordController.text = "";
                          _confirmPasswordController.text = "";
                          // print(isSignInNotifier.value.toString());
                        },
                        child: Text(
                          isSignInNotifier.value
                              ? "Register Now ."
                              : "Sign In .",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
