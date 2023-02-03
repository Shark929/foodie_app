import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel2 {
  late String username;
  late int quantity;
  late String customization;
  late String uid;
  String? cartId;
  late String code;
  late String foodName;
  late String vendorId;
  late String foodPic;
  late double foodPrice;
  late String pickupTime;
  late bool isDineIn;

  CartModel2({
    required this.username,
    required this.quantity,
    required this.customization,
    required this.uid,
    this.cartId,
    required this.code,
    required this.foodName,
    required this.foodPic,
    required this.foodPrice,
    required this.vendorId,
    required this.pickupTime,
    required this.isDineIn,
  });

  CartModel2.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    username = documentSnapshot['username'];
    quantity = documentSnapshot['quantity'];
    customization = documentSnapshot['customization'];
    uid = documentSnapshot['uid'];
    cartId = documentSnapshot.id;
    code = documentSnapshot['code'];
    foodName = documentSnapshot['foodName'];
    foodPic = documentSnapshot['foodPic'];
    foodPrice = documentSnapshot['foodPrice'];
    vendorId = documentSnapshot['vendorId'];
    pickupTime = documentSnapshot['pickupTime'];
    isDineIn = documentSnapshot['isDineIn'];
  }
}
