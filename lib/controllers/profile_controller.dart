import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> menus = [];

    QuerySnapshot myMenus = await firebaseFirestore
        .collection("menus")
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myMenus.docs.length; i++) {
      menus.add((myMenus.docs[i].data()! as dynamic)['imageUrl']);
    }

    DocumentSnapshot userDoc =
        await firebaseFirestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String username = userData['username'];
    String email = userData['email'];
    String profilePicture = userData['profilePicture'];
    // String phone = userData['phone'];

    _user.value = {
      'profilePicture': profilePicture,
      'username': username,
      'email': email,
    };
    update();
  }
}
