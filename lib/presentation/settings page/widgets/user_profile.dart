// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:chat_app/presentation/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/users_bloc.dart';

class GoToProfile extends StatefulWidget {
  const GoToProfile({
    super.key,
  });

  @override
  State<GoToProfile> createState() => _GoToProfileState();
}

class _GoToProfileState extends State<GoToProfile> {
  // just a simple animation
  Timer? _timer;
  ValueNotifier<bool> imagePosNotifier = ValueNotifier(false);
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      imagePosNotifier.value = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Profile Photo"),
        actions: [
          // edit button
          IconButton(
              onPressed: () {
                // calling event
                BlocProvider.of<UsersBloc>(context)
                    .add(UpdateProfilePhoto(context: context));
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: imagePosNotifier,
        builder: (context, value, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            child: Center(
              child: Column(
                mainAxisAlignment: imagePosNotifier.value
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: imagePosNotifier.value
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  // current user profile image
                  Padding(
                    padding: imagePosNotifier.value
                        ? const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15)
                        : const EdgeInsets.only(bottom: 1),
                    child: ClipRRect(
                      borderRadius: imagePosNotifier.value
                          ? BorderRadius.circular(0)
                          : BorderRadius.circular(30),
                      child: Container(
                        width: imagePosNotifier.value ? double.infinity : 70,
                        height: imagePosNotifier.value ? 250 : 70,
                        color: Colors.black,
                        child: BlocBuilder<UsersBloc, UsersState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state.currentUser != null) {
                              if (state.currentUser!.image.isNotEmpty) {
                                return Image.network(
                                  state.currentUser!.image,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return const Center(
                                    child: Text(
                                  "upload your image so that your friends can see .",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ));
                              }
                            } else {
                              return kWidth;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
