import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/user_model.dart';

class UserFirestoreDb {
  //create
  static addUser(UserModel userModel) async {
    await firebaseFirestore.collection('users').add({
      'username': userModel.username,
      'email': userModel.email,
      'phoneNum': userModel.phoneNum,
      'profilePicture': userModel.profilePicture,
    });
  }

  //read
  static Stream<List<UserModel>> userStream() {
    return firebaseFirestore
        .collection('users')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<UserModel> users = [];

      for (var user in querySnapshot.docs) {
        final userModel =
            UserModel.fromDocumentSnapshot(documentSnapshot: user);

        users.add(userModel);
      }

      return users;
    });
  }

  //update
  static updateUsername(String username, documentId) {
    firebaseFirestore.collection('users').doc(documentId).update(
      {
        'username': username,
      },
    );
  }

  static updatePhone(String phone, documentId) {
    firebaseFirestore.collection('users').doc(documentId).update(
      {
        'phoneNum': phone,
      },
    );
  }

  //delete
  static deleteUser(String documentId) {
    firebaseFirestore.collection('users').doc(documentId).delete();
  }
}
