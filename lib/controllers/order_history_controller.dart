import 'package:foodie_app/Firestore/order_history_db.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  Rx<List<MyCartModel>> orderHistoryList = Rx<List<MyCartModel>>([]);

  List<MyCartModel> get orderHistory => orderHistoryList.value;

  @override
  void onReady() {
    orderHistoryList.bindStream(OrderHistoryFirestoreDb.myCartStream());
  }
}
