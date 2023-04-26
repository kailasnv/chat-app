// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_app/presentation/core/constants.dart';
import 'package:chat_app/presentation/home_page/widgets/friend_tile.dart';
import 'package:chat_app/presentation/home_page/widgets/search_textfield.dart';
import 'package:chat_app/presentation/settings%20page/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../application/bloc/users_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //controller for search
  final searchController = TextEditingController();

  @override
  void initState() {
    /* calling events */
    context.read<UsersBloc>().add(LoadCurrentUser());
    // calling this event helps to reload the current user data somehow
    context.read<UsersBloc>().add(LoadOtherUsers(searchQuery: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* gradient screen  backgnd */
      body: CustomScrollView(
        slivers: [
          /* Appbar section */
          SliverAppBar(
            // menu button
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ));
                  },
                  icon: const Icon(Icons.menu_rounded)),
              kWidth,
            ],

            elevation: 0,
            expandedHeight: 110,
            leading: Lottie.asset(
              "assets/animations/customer.json",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                "Chat with .",
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),

            floating: true,
            pinned: true,
            snap: true,
            bottom: AppBar(
              elevation: 0,
              title: HomeSearchField(controller: searchController),
            ),
          ),

          /* BODY SECTION */
          SliverList(
            delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    // show loading ...
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 140),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )),
                      );
                    }
                    // show  search results
                    if (state.otherUsers != null) {
                      if (state.otherUsers!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.otherUsers!.length,
                          itemBuilder: (context, index) {
                            User? _currentUser =
                                FirebaseAuth.instance.currentUser;
                            if (_currentUser != null) {
                              return FriendTile(
                                currentUserUid: _currentUser.uid,
                                friendUid: state.otherUsers![index]['uid'],
                                friendName: state.otherUsers![index]['name'],
                                friendImage: state.otherUsers![index]['image'],
                                lastMsg: "",
                              );
                            }
                          },
                        );
                      } else {
                        // this just reloads the home page somehow !
                        // and shows the recent users that had a chat with current user
                        context.read<UsersBloc>().add(LoadCurrentUser());
                        return kWidth;
                      }
                    }
                    // home data
                    if (state.currentUser != null) {
                      // if search results is empty , show recents chats .
                      // Listening to Streams..
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(state.currentUser!.uid)
                            .collection('messages')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // recents chats
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                endIndent: 25,
                                indent: 25,
                                color: Colors.black,
                              ),
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var friendId = snapshot.data!.docs[index].id;
                                var lastMsg =
                                    snapshot.data!.docs[index]['last_msg'];

                                return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(friendId)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var friendData = snapshot.data;

                                      return FriendTile(
                                        currentUserUid: state.currentUser!.uid,
                                        friendUid: friendId,
                                        friendName: friendData!['name'],
                                        friendImage: friendData['image'],
                                        lastMsg: lastMsg ?? "",
                                      );
                                    } else {
                                      return kWidth;
                                    }
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: LinearProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.black,
                              value: 1,
                              minHeight: 1,
                            ));
                          }
                        },
                      );
                    } else {
                      // when there is no friend in the recent chat section
                      return const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 300),
                            child: Text(
                              "search a user and start messaging !",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
