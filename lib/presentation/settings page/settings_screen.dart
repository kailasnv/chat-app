import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/settings%20page/widgets/user_profile.dart';
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
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.currentUser != null) {
                      if (state.currentUser!.image.isNotEmpty) {
                        return GestureDetector(
                          onTap: () =>
                              // go to profile edit screen
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GoToProfile(),
                          )),
                          child: ClipRRect(
                            // current user profile image
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              state.currentUser!.image,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () =>
                              // go to profile edit screen
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GoToProfile(),
                          )),
                          child: ClipRRect(
                            // current user profile image
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: 70,
                                width: 70,
                                color: Colors.black,
                                child: const Center(
                                    child: Icon(Icons.person,
                                        color: Colors.white))),
                          ),
                        );
                      }
                    } else {
                      return const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.person_2_rounded),
                      );
                    }
                  },
                ),
                kWidth,
                // N A M E
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.currentUser != null) {
                      return Text(
                        state.currentUser!.name,
                        style: const TextStyle(
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
                return Text("signed in as : ${state.currentUser!.email}");
              } else {
                return kWidth;
              }
            },
          ),
          kHeight,
          /*
             Sign Out / Log out 
           */
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
