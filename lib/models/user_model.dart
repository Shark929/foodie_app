import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? userId;
  late String username;
  late String email;
  late String phoneNum;
  late String profilePicture;

  UserModel({
    this.userId,
    required this.username,
    required this.email,
    required this.phoneNum,
    required this.profilePicture,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    username = documentSnapshot['username'];
    email = documentSnapshot['email'];
    phoneNum = documentSnapshot['phoneNum'];
    profilePicture = documentSnapshot['profilePicture'];
  }
}
