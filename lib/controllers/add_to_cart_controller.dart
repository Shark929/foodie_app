import 'package:foodie_app/Firestore/add_to_my_cart_firestore_db.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:get/get.dart';

class AddToMyCartController extends GetxController {
  Rx<List<MyCartModel>> myCartList = Rx<List<MyCartModel>>([]);

  List<MyCartModel> get myCart => myCartList.value;

  @override
  void onReady() {
    myCartList.bindStream(AddToMyCartFirestoreDb.myCartStream());
  }
}
