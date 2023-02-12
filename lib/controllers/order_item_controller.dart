import 'package:foodie_app/Firestore/order_firestore_db.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:get/get.dart';

class OrderItemController2 extends GetxController {
  final String orderNumber;
  OrderItemController2({
    required this.orderNumber,
  });
  Rx<List<MyCartModel>> orderList = Rx<List<MyCartModel>>([]);

  List<MyCartModel> get order => orderList.value;

  @override
  void onReady() {
    orderList.bindStream(OrderFirestoreDb.orderDetailStream(orderNumber));
  }
}
