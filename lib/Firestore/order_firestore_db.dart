import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:foodie_app/models/order_model.dart';

class OrderFirestoreDb {
  static addToOrder(OrderModel orderModel) {
    firebaseFirestore.collection('order').doc(orderModel.orderNumber).set({
      'customerId': orderModel.customerId,
      'isDineIn': orderModel.isDineIn,
      'code': orderModel.code,
      'orderNumber': orderModel.orderNumber,
      'time': orderModel.time,
      'totalPrice': orderModel.totalPrice,
      'vendorId': orderModel.vendorId,
    });
  }

  static addOrderList(String orderNum, MyCartModel mcModel) {
    firebaseFirestore
        .collection('order')
        .doc(orderNum)
        .collection('orderList')
        .add({
      'customerId': mcModel.customerId,
      'customization': mcModel.customization,
      'itemDescription': mcModel.itemDescription,
      'itemName': mcModel.itemName,
      'itemPicture': mcModel.itemPicture,
      'itemPrice': mcModel.itemPrice,
      'myCartId': mcModel.myCartId,
      'quantity': mcModel.quantity,
      'totalPrice': mcModel.totalPrice,
      'vendorId': mcModel.vendorId,
    });
  }

  static Stream<List<OrderModel>> orderStream() {
    return firebaseFirestore
        .collection('order')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<OrderModel> orders = [];
      for (var order in querySnapshot.docs) {
        final orderModel = OrderModel.fromDocumentSnapshot(order);

        orders.add(orderModel);
      }
      return orders;
    });
  }

  static Stream<List<MyCartModel>> orderDetailStream(String orderNumber) {
    return firebaseFirestore
        .collection('order')
        .doc(orderNumber)
        .collection('orderList')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MyCartModel> orders = [];
      for (var order in querySnapshot.docs) {
        final orderModel = MyCartModel.fromDocumentSnapshot(order);
        orders.add(orderModel);
      }
      return orders;
    });
  }
}
