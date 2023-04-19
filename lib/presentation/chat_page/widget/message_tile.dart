import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String messages;
  final bool isItMe;
  const MessageTile({
    super.key,
    required this.isItMe,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment:
            isItMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isItMe ? Colors.teal : Colors.teal[700],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(child: Text(messages)),
          ),
        ],
      ),
    );
  }
}
