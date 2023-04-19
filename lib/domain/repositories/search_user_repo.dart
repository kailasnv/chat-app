import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUsersRepo {
  static Future<List<Map<String, dynamic>>> fetchNewFriends(
    TextEditingController searchController,
    String currentUserEmail,
  ) async {
    // list to store users
    List<Map<String, dynamic>> friendsList = [];
    /*  Fetch other user based on controller text */
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          return;
        }

        for (var user in snapshot.docs) {
          /// for not showing himself while searching
          if (user.data()['email'] != currentUserEmail) {
            friendsList.add(user.data());
          }
          //

          // friendsList.add(user.data());
        }
      },
    );
    return friendsList;
  }
}
