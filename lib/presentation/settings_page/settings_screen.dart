import 'package:chat_app/presentation/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc_current_user/current_user_bloc.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  bool isImagePresent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: const Text("Settings"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),

        //
        body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
          builder: (context, state) {
            if (state.userData != null) {
              if (state.userData!.image.isNotEmpty) {
                isImagePresent = true;
              } else {
                isImagePresent = false;
              }
              return Column(
                children: [
                  kHeight,
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: CircleAvatar(
                      radius: 100,
                      child: isImagePresent
                          ? Image.network(state.userData!.image)
                          : Image.asset(
                              "assets/images/chat.png",
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  kHeight,
                  Text(
                    state.userData!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  kHeight,
                  Text(
                    "Signed in as ${state.userData!.email}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  //
                ],
              );
            } else {
              return const Center(child: Text("Loading ..."));
            }
          },
        ));
  }
}
