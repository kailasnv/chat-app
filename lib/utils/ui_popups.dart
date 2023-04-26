import 'package:flutter/material.dart';

class ShowPopUps {
  // circle loading indicator
  static void circleLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }

  // show error message snackbar
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black)),
        margin: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
