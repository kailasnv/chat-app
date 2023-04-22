import 'package:chat_app/presentation/chat%20page/chat_screen.dart';
import 'package:chat_app/presentation/core/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendTile extends StatelessWidget {
  final String currentUserUid;
  final String friendUid;
  final String friendName;
  final String friendImage;
  final String lastMsg;

  FriendTile({
    super.key,
    required this.currentUserUid,
    required this.friendUid,
    required this.friendName,
    required this.friendImage,
    required this.lastMsg,
  });

  ValueNotifier<bool> showImageNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    if (friendImage.isEmpty) {
      showImageNotifier.value = false;
    } else {
      showImageNotifier.value = true;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                currentUserUid: currentUserUid,
                friendUid: friendUid,
                friendName: friendName,
                friendImage: friendImage,
              ),
            ),
          );
        },
        child: Container(
          color: Colors.transparent,
          height: 100,
          width: double.infinity,
          // padding: ,
          child: Row(
            children: [
              // image
              ValueListenableBuilder(
                valueListenable: showImageNotifier,
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 55,
                      width: 55,
                      color: Colors.black,
                      child: showImageNotifier.value
                          ? Image.network(friendImage, fit: BoxFit.cover)
                          : const Icon(Icons.person, color: Colors.white),
                    ),
                  );
                },
              ),
              kWidth,
              // name
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friendName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      "last msg  $lastMsg",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
