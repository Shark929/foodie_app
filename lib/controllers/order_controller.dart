import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final Rx<List<OrderModel>> _orders = Rx<List<OrderModel>>([]);
  List<OrderModel> get order => _orders.value;
  String _orderId = "";

  updateId({required String id}) {
    _orderId = id;
    getOrder();
  }

  getOrder() async {
    _orders.bindStream(firebaseFirestore
        .collection('orders')
        .doc(_orderId)
        .collection('myorder')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<OrderModel> returnValue = [];

      for (var element in querySnapshot.docs) {
        returnValue.add(OrderModel.fromSnap(element));
      }

      return returnValue;
    }));
  }

  postOrder({
    required List quantities,
    required List totalPrice,
    required String vendorName,
    required List items,
    required TimeOfDay time,
    required List prices,
  }) async {
    try {
      DocumentSnapshot orderDoc = await firebaseFirestore
          .collection('orders')
          .doc(authController.user.uid)
          .get();

      var allDocs = await firebaseFirestore
          .collection('orders')
          .doc(authController.user.uid)
          .collection('myorder')
          .get();

      int length = allDocs.docs.length;

      OrderModel order = OrderModel(
        uid: authController.user.uid,
        id: "Order $length",
        vendorName: vendorName,
        totalPrice: totalPrice,
        prices: prices,
        items: items,
        quantities: quantities,
      );

      await firebaseFirestore
          .collection('orders')
          .doc(_orderId)
          .collection('myorder')
          .doc('Order $length')
          .set(order.toJson());

      DocumentSnapshot docSnap =
          await firebaseFirestore.collection('orders').doc(_orderId).get();
      // firebaseFirestore.collection('wallets').doc(_walletId).update({

      // });
    } catch (e) {
      Get.snackbar("Cart Error", e.toString());
    }
  }
}
