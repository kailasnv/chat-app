import 'package:chat_app/presentation/chat_page/chat_screen.dart';
import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/home_page/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc_current_user/current_user_bloc.dart';
import '../../application/bloc_search/search_bloc.dart';
import '../widgets_common/users_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /*  calling events */
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserDataEvent());
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      /* appbar section */
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 55),
        child: CustomAppbar(),
      ),
      /* List of messaged  users tile */
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var friendId = snapshot.data!.docs[index].id;
                var lastMsg = snapshot.data!.docs[index]['last_msg'];

                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(friendId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var friend = snapshot.data;
                      return BlocBuilder<CurrentUserBloc, CurrentUserState>(
                        builder: (context, state) {
                          if (state.userData != null) {
                            return ListTile(
                              leading: const CircleAvatar(),
                              title: Text(
                                friend!['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Container(
                                  child: Text(
                                lastMsg,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    currentUser: state.userData!,
                                    friendID: friendId,
                                    friendName: friend['name'],
                                    friendImage: friend['image'],
                                  ),
                                ));
                              },
                            );
                          } else {
                            return kWidth;
                          }
                        },
                      );
                    } else {
                      return kHeight;
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
