import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/widgets_common/smooth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc/users_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // calling current events
    BlocProvider.of<UsersBloc>(context).add(LoadCurrentUser());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
      ),
      body: Column(
        children: [
          // profile
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15, bottom: 10),
            child: Row(
              children: [
                // image
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.currentUser != null) {
                      // place profile image here .
                      return const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person_2_rounded),
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person_2_rounded),
                      );
                    }
                  },
                ),
                kWidth,
                // name
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.currentUser != null) {
                      return Text(
                        state.currentUser!.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return kWidth;
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            endIndent: 25,
            indent: 25,
          ),
          // other settings
          kHeight,
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state.currentUser != null) {
                return Text(
                  "signed in as : ${state.currentUser!.email}",
                  style: const TextStyle(color: Colors.black),
                );
              } else {
                return kWidth;
              }
            },
          ),
          kHeight,
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: const SmoothButton(
              buttonWidth: 300,
              buttonTitle: "Log Out",
              buttonColor: Colors.black,
              titleColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
