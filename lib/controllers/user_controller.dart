import 'package:foodie_app/Firestore/user_firestore_db.dart';
import 'package:foodie_app/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<List<UserModel>> userList = Rx<List<UserModel>>([]);

  List<UserModel> get users => userList.value;

  @override
  void onReady() {
    userList.bindStream(UserFirestoreDb.userStream());
  }
}
