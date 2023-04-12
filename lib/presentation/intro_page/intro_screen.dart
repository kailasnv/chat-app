import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/sign_in_out_page/sign_user_screen.dart';
import 'package:chat_app/presentation/widgets_common/smooth_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // a intro animated logo ( responsive )
            screenWidth < 460
                ? Lottie.asset("assets/animations/lovemessage.json")
                : Lottie.asset(
                    "assets/animations/lovemessage.json",
                    width: 150,
                    fit: BoxFit.cover,
                  ),
            //  greetings ....
            const Text(
              "Hey !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // intro texts about app
            const Text(
              "Get connected with your Friends and Family",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // tips
            Text(
              "Tap the Get Started to Enter into the App and Start messaging .",
              style: TextStyle(
                color: Colors.deepPurple.shade100,
                fontSize: 10,
              ),
            ),
            kHeight,
            // Get started  Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    // builder: (context) => const LoginOrRegisterPage(),
                    builder: (context) => SignUserScreen(),
                  ),
                ),
                child: SmoothButton(
                  buttonWidth: 250,
                  buttonTitle: "Get Started",
                  buttonColor: Colors.deepPurple.shade400,
                  titleColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
