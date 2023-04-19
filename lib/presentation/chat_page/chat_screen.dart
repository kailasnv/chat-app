// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:chat_app/presentation/chat_page/widget/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final UserModal currentUser;
  final String friendID;
  final String friendName;
  final String friendImage;
  ChatScreen({
    super.key,
    required this.currentUser,
    required this.friendID,
    required this.friendName,
    required this.friendImage,
  });

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendName),
      ),
      /*     */
      body: Column(
        children: [
          //1 - chats
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.uid)
                  .collection('messages')
                  .doc(friendID)
                  .collection('chats')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("say Hi ."));
                  }
                  // if there is any chats available
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isItMe = snapshot.data!.docs[index]['senderId'] ==
                          currentUser.uid;
                      return MessageTile(
                        isItMe: isItMe,
                        messages: snapshot.data!.docs[index]['message'],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          /*
            2nd section - send message to others 
         */
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // textfield
                Container(
                  width: 275,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "write your message",
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // when  send button  Clicks
                GestureDetector(
                  onTap: () async {
                    String _message = _messageController.text;
                    _messageController.clear();
                    /* store message on current uid  */
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser.uid)
                        .collection('messages')
                        .doc(friendID)
                        .collection('chats')
                        .add({
                      'senderId': currentUser.uid,
                      'receiverId': friendID,
                      'message': _message,
                      'type': "text",
                      'date': DateTime.now(),
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .collection('messages')
                          .doc(friendID)
                          .set({
                        'last_msg': _message,
                      });
                    });
                    /* store message on friend uid  */
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(friendID)
                        .collection('messages')
                        .doc(currentUser.uid)
                        .collection('chats')
                        .add({
                      'senderId': currentUser.uid,
                      'receiverId': friendID,
                      'message': _message,
                      'type': "text",
                      'date': DateTime.now(),
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendID)
                          .collection('messages')
                          .doc(currentUser.uid)
                          .set({
                        'last_msg': _message,
                      });
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.teal[300],
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
