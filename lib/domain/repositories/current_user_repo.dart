import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserRepo {
  static Future<UserModal> getUserData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      UserModal userModal = UserModal.fromJson(userData);

      return userModal;
    } else {
      throw Exception();
    }
  }
}
