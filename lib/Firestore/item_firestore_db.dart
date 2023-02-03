import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/menu_model.dart';

class ItemFirestore {
  //create

  //read
  static Stream<List<ItemModel>> itemStream() {
    return firebaseFirestore
        .collection('menus')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ItemModel> items = [];
      for (var item in querySnapshot.docs) {
        final itemModel =
            ItemModel.fromDocumentSnapshot(documentSnapshot: item);
        items.add(itemModel);
      }
      return items;
    });
  }
  //update

  //delete
}
