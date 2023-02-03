import 'package:foodie_app/Firestore/order_firestore.dart';
import 'package:foodie_app/models/cart_model2.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<List<CartModel2>> carts = Rx<List<CartModel2>>([]);
  List<CartModel2> get cartList => carts.value;

  @override
  void onReady() {
    carts.bindStream(OrderFirestoreDb.orderStream());
  }
}
