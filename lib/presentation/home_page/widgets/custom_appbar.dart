import 'package:chat_app/presentation/search%20page/search_screen.dart';
import 'package:chat_app/presentation/settings_page/settings_screen.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("chat app."),
      actions: [
        // search user button
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
            },
            icon: const Icon(Icons.search)),

        // navigate to settings page
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: const Icon(Icons.menu))
      ],
    );
  }
}
