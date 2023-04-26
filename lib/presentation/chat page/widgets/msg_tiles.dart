import 'package:chat_app/presentation/widgets_common/blur_skin.dart';
import 'package:flutter/material.dart';

class MessagesTile extends StatelessWidget {
  final String messages;
  final bool isItMe;
  const MessagesTile({
    super.key,
    required this.messages,
    required this.isItMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isItMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: isItMe
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
            child: BlurSkin(
              child: Container(
                color: isItMe
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.all(15),
                child: Text(
                  messages,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
