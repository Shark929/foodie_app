import 'package:foodie_app/Firestore/order_firestore_db.dart';
import 'package:foodie_app/models/order_model.dart';
import 'package:get/get.dart';

class OrderController2 extends GetxController {
  Rx<List<OrderModel>> orderList = Rx<List<OrderModel>>([]);

  List<OrderModel> get order => orderList.value;

  @override
  void onReady() {
    orderList.bindStream(OrderFirestoreDb.orderStream());
  }
}
