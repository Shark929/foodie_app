import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/cart_model2.dart';

class OrderFirestoreDb {
  //create
  static addToVendorCart(CartModel2 cartModel2) async {
    await firebaseFirestore.collection('vendorCart').add({
      'cartId': cartModel2.cartId,
      'code': cartModel2.code,
      'customization': cartModel2.customization,
      'foodName': cartModel2.foodName,
      'foodPic': cartModel2.foodPic,
      'foodPrice': cartModel2.foodPrice,
      'quantity': cartModel2.quantity,
      'uid': cartModel2.uid,
      'username': cartModel2.username,
      'vendorId': cartModel2.vendorId,
      'pickupTime': cartModel2.pickupTime,
      'isDineIn': cartModel2.isDineIn,
    });
  }

  //read
  static Stream<List<CartModel2>> orderStream() {
    return firebaseFirestore
        .collection('vendorCart')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<CartModel2> carts = [];

      for (var cart in querySnapshot.docs) {
        final cartModel =
            CartModel2.fromDocumentSnapshot(documentSnapshot: cart);
        carts.add(cartModel);
      }

      return carts;
    });
  }
  //update

  //delete
}
