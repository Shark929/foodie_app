import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/models/my_cart_model.dart';

class OrderModel {
  String? orderId;
  late String totalPrice;
  late String orderNumber;
  late bool isDineIn;
  late String time;
  late String customerId;
  late String code;
  late String vendorId;

  OrderModel({
    required this.customerId,
    required this.isDineIn,
    required this.code,
    required this.orderNumber,
    required this.time,
    required this.totalPrice,
    required this.vendorId,
  });

  OrderModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    orderId = documentSnapshot.id;
    totalPrice = documentSnapshot['totalPrice'];
    orderNumber = documentSnapshot['orderNumber'];
    isDineIn = documentSnapshot['isDineIn'];
    time = documentSnapshot['time'];
    customerId = documentSnapshot['customerId'];
    code = documentSnapshot['code'];
    vendorId = documentSnapshot['vendorId'];
  }
}
