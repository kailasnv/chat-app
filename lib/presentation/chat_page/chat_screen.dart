import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  ChatScreen({super.key, required this.name});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(name),
      ),
      body: Column(
        children: [
          Expanded(
            // use listview here
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("messages"),
                );
              },
            ),
          ),
          //
          // send message to others
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
                // send button
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
