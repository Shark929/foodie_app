import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/cart_model2.dart';

class CartFirestore {
  //create
  static addCart(CartModel2 cartModel2) async {
    await firebaseFirestore.collection('cart').add({
      // 'cartId': cartModel2.cartId,
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
  static Stream<List<CartModel2>> cartStream() {
    return firebaseFirestore
        .collection('cart')
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
  static updateTime(String time, documentId) {
    firebaseFirestore.collection('cart').doc(documentId).update(
      {
        'pickupTime': time,
      },
    );
  }

  static updateDineIn(bool isDineIn, documentId) {
    firebaseFirestore.collection('cart').doc(documentId).update(
      {
        'isDineIn': isDineIn,
      },
    );
  }

  //update the code
  static updateCode(String code, documentId) {
    firebaseFirestore.collection('cart').doc(documentId).update(
      {
        'code': code,
      },
    );
  }
  //delete

  static deleteCart(String documentId) {
    firebaseFirestore.collection('cart').doc(documentId).delete();
  }
}
