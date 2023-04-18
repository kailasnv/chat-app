import 'package:chat_app/presentation/core/constants.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final String? userImage;
  const UserTile({
    super.key,
    required this.userName,
    this.userImage,
  });

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
          Text(userName),
        ],
      ),
    );
  }
}
