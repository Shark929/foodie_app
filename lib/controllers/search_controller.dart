import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<Menu>> _searchMenu = Rx<List<Menu>>([]);
  List<Menu> get searchMenus => _searchMenu.value;

  //search by user input
  searchMenu(String searchInput) async {
    _searchMenu.bindStream(firebaseFirestore
        .collection('menus')
        .where('category', isGreaterThanOrEqualTo: searchInput)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Menu> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(Menu.fromSnap(element));
      }

      return returnValue;
    }));
  }
}
