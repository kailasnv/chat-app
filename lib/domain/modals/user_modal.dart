import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  final String name;
  final String email;
  final String image;
  final String uid;

  final Timestamp date;

  UserModal({
    required this.name,
    required this.email,
    required this.image,
    required this.uid,
    required this.date,
  });

  // convert json format to usermodal
  factory UserModal.fromJson(DocumentSnapshot snapshot) {
    return UserModal(
      name: snapshot['name'],
      email: snapshot['email'],
      image: snapshot['image'],
      uid: snapshot['uid'],
      date: snapshot['date'],
    );
  }
}
