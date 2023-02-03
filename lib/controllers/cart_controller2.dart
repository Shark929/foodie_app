import 'package:foodie_app/Firestore/cart_firestore_db.dart';
import 'package:foodie_app/models/cart_model2.dart';
import 'package:get/get.dart';

class CartController2 extends GetxController {
  Rx<List<CartModel2>> cartList = Rx<List<CartModel2>>([]);
  List<CartModel2> get cart => cartList.value;

  @override
  onReady() {
    cartList.bindStream(CartFirestore.cartStream());
  }
}
