import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ////
  //*

  Future<UserModal> getCurrentUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      UserModal userModal = UserModal.fromJson(userData);
      return userModal;
    } else {
      print("NO CURRENT USER !");
      throw Exception();
    }
  }
  //*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("chatMe"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " Signed in as : {_userModal.}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      //
      body: SafeArea(
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text("names"),
            );
          },
        ),
      ),
    );
  }
}
