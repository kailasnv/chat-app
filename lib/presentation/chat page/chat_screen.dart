// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_app/presentation/chat%20page/widgets/msg_textfeild.dart';
import 'package:chat_app/presentation/chat%20page/widgets/msg_tiles.dart';
import 'package:chat_app/presentation/core/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserUid;
  final String friendUid;
  final String friendName;
  final String friendImage;

  const ChatScreen({
    super.key,
    required this.currentUserUid,
    required this.friendUid,
    required this.friendName,
    required this.friendImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
// controller for message
  final messageController = TextEditingController();

// this manages the profile image conditions.
// if the image field is not empty - shows the image , otherwise shows a black background .
  bool canShowImage = false;
  @override
  void initState() {
    if (widget.friendImage.isNotEmpty) {
      setState(() {
        canShowImage = true;
      });
    } else {
      setState(() {
        canShowImage = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Appbar section */
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.friendName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.more_vert),
          kWidth,
        ],
      ),
      body: Stack(
        // this stack is used only just for showing profile image
        // over everything .
        children: [
          // profile image
          Align(
            alignment: Alignment.topCenter,
            child: canShowImage
                ? Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.network(
                          widget.friendImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : kWidth,
          ),
          // messages listview
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Messages shows here - the streambuilder always listen to the stream
              // and rebuilds its child widget each time the stream has a update
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentUserUid)
                    .collection('messages')
                    .doc(widget.friendUid)
                    .collection('chats')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // if snapshot is empty - say hi
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("say hi ."),
                      );
                    } else {
                      // if snapshot 's data is not empty , showing the messages
                      // in the listview builder.
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // checking whether the msg is senf by me or by other
                            bool isItMe = snapshot.data!.docs[index]
                                    ['senderId'] ==
                                widget.currentUserUid;

                            return MessagesTile(
                              messages: snapshot.data!.docs[index]['message'],
                              isItMe: isItMe,
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.black, strokeWidth: 2));
                  }
                },
              ),
              /* send messsages field - section */
              MessageTextFeild(
                messageController: messageController,
                currentUid: widget.currentUserUid,
                friendUid: widget.friendUid,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
