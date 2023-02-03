import 'package:foodie_app/Firestore/item_firestore_db.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  Rx<List<ItemModel>> itemList = Rx<List<ItemModel>>([]);
  List<ItemModel> get items => itemList.value;

  @override
  void onReady() {
    itemList.bindStream(ItemFirestore.itemStream());
  }
}
