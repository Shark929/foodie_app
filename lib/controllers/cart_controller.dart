import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/cart_model.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final Rx<List<CartModel>> _carts = Rx<List<CartModel>>([]);
  List<CartModel> get cart => _carts.value;
  String _cartId = "";

  updateId({required String id}) {
    _cartId = id;
    getCart();
  }

  getCart() async {
    _carts.bindStream(firebaseFirestore
        .collection('users')
        .doc(_cartId)
        .collection('cart')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<CartModel> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(CartModel.fromSnap(element));
      }
      return returnValue;
    }));
  }

  // postCart({
  //   required String customization,
  //   required int quantity,
  //   // required Menu menu,
  // }) async {
  //   try {
  //     if (customization.isNotEmpty) {
  //       DocumentSnapshot userDoc = await firebaseFirestore
  //           .collection('users')
  //           .doc(authController.user.uid)
  //           .get();

  //       var allDocs = await firebaseFirestore
  //           .collection('users')
  //           .doc(authController.user.uid)
  //           .collection('cart')
  //           .get();

  //       int length = allDocs.docs.length;

  //       CartModel cart = CartModel(
  //         username: (userDoc.data()! as dynamic)['username'],
  //         uid: authController.user.uid,
  //         id: "Cart $length",
  //         code: "0",
  //         customization: customization,
  //         quantity: quantity,
  //         foodName: menu.foodname,
  //         foodPic: menu.imageUrl,
  //         foodPrice: double.parse(menu.foodPrice),
  //         vendorname: menu.vendorName,
  //       );

  //       await firebaseFirestore
  //           .collection('users')
  //           .doc(_cartId)
  //           .collection('cart')
  //           .doc('Cart $length')
  //           .set(cart.toJson());

  //       DocumentSnapshot docSnap =
  //           await firebaseFirestore.collection('users').doc(_cartId).get();
  //       // firebaseFirestore.collection('wallets').doc(_walletId).update({

  //       // });
  //     }
  //   } catch (e) {
  //     Get.snackbar("Cart Error", e.toString());
  //   }
  // }
}
