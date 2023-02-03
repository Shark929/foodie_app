// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:foodie_app/constants/constant.dart';
// import 'package:foodie_app/models/menu_model.dart';
// import 'package:get/get.dart';

// class MenuController1 extends GetxController {
//   final Rx<List<Menu>> _menuList = Rx<List<Menu>>([]);

//   List<Menu> get menuList => _menuList.value;
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     _menuList.bindStream(firebaseFirestore
//         .collection('menus')
//         .snapshots()
//         .map((QuerySnapshot querySnapshot) {
//       List<Menu> returnValue = [];
//       for (var element in querySnapshot.docs) {
//         returnValue.add(Menu.fromSnap(element));
//       }

//       return returnValue;
//     }));
//   }
// }
