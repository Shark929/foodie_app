import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String profilePicture;
  String email;
  String uid;
  String code;

  User({
    required this.username,
    required this.profilePicture,
    required this.email,
    required this.uid,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilePicture": profilePicture,
        "email": email,
        "uid": uid,
        "code": code,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      profilePicture: snapshot['profilePicture'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      code: snapshot['code'],
    );
  }
}
