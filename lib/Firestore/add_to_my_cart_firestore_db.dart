import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/my_cart_model.dart';

class AddToMyCartFirestoreDb {
  static addToMyCart(MyCartModel myCartModel) async {
    await firebaseFirestore.collection('mycart').add({
      'customization': myCartModel.customization,
      'itemDescription': myCartModel.itemDescription,
      'itemName': myCartModel.itemName,
      'itemPrice': myCartModel.itemPrice,
      'quantity': myCartModel.quantity,
      'totalPrice': myCartModel.totalPrice,
      'customerId': myCartModel.customerId,
      'itemPicture': myCartModel.itemPicture,
      'vendorId': myCartModel.vendorId,
    });
  }

  //read
  static Stream<List<MyCartModel>> myCartStream() {
    return firebaseFirestore
        .collection('mycart')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MyCartModel> mycarts = [];
      for (var cart in querySnapshot.docs) {
        final myCartModel = MyCartModel.fromDocumentSnapshot(cart);
        mycarts.add(myCartModel);
      }
      return mycarts;
    });
  }

  //delete
  static deleteMyCart(String docId) {
    firebaseFirestore.collection('mycart').doc(docId).delete();
  }
}
