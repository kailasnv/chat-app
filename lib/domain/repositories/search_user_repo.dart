import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUsersRepo {
  static Future<List<Map<String, dynamic>>> fetchNewFriends(
    String searchQuery,
  ) async {
    // list to store users
    List<Map<String, dynamic>> friendsList = [];
    /*  Fetch other user based on controller text */
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchQuery)
        .get()
        .then(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          // TODO :show snack bar - no users
          return;
        }

        snapshot.docs.forEach(
          (user) {
            friendsList.add(user.data());
          },
        );
      },
    );
    return friendsList;
  }
}
