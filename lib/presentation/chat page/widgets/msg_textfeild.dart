// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*  CUSTOM MESSAGE TEXTFEILD WIDGET  */

class MessageTextFeild extends StatelessWidget {
  final TextEditingController messageController;
  final String currentUid;
  final String friendUid;

  const MessageTextFeild({
    super.key,
    required this.messageController,
    required this.currentUid,
    required this.friendUid,
  });

  // upload messages to firebase firestore database method
  Future uploadMessagesToFirebaseFirestore(String message) async {
    // upload to current user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('messages')
        .doc(friendUid)
        .collection('chats')
        .add({
      'senderId': currentUid,
      'receiverId': friendUid,
      'message': message,
      'type': "text",
      'date': DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection('messages')
          .doc(friendUid)
          .set({
        'last_msg': message,
      });
    });

    // upload to current user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(friendUid)
        .collection('messages')
        .doc(currentUid)
        .collection('chats')
        .add({
      'senderId': currentUid,
      'receiverId': friendUid,
      'message': message,
      'type': "text",
      'date': DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(friendUid)
          .collection('messages')
          .doc(currentUid)
          .set({
        'last_msg': message,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: TextField(
            controller: messageController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "write your message..",
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 10, top: 15),

              // S E N D button
              suffixIcon: IconButton(
                // onPressed: () => onSendMethod,
                onPressed: () async {
                  String _message = messageController.text;
                  messageController.clear();

                  uploadMessagesToFirebaseFirestore(_message);
                },
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
