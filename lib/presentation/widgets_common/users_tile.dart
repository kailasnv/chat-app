import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:chat_app/presentation/chat_page/chat_screen.dart';
import 'package:chat_app/presentation/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc_current_user/current_user_bloc.dart';

class UserTile extends StatelessWidget {
  final String friendID;
  final String friendName;
  final String friendImage;
  const UserTile(
      {super.key,
      required this.friendID,
      required this.friendName,
      required this.friendImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          // profile image
          kWidth,
          const CircleAvatar(
            radius: 27,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          // user name
          kWidth,
          Text(friendName),
          // message him .
          const Spacer(),
          BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              if (state.userData != null) {
                return IconButton(
                    onPressed: () {
                      // open chat page with him
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          currentUser: state.userData!,
                          friendID: friendID,
                          friendName: friendName,
                          friendImage: friendImage,
                        ),
                      ));
                    },
                    icon: const Icon(Icons.message, color: Colors.white));
              } else {
                return kWidth;
              }
            },
          ),
          kWidth,
        ],
      ),
    );
  }
}
