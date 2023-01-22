import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:get/get.dart';

class uploadMenuController extends GetxController {
  Future<String> _uploadMenuToStorage(
      {required String id, required String imagePath}) async {
    Reference ref = firebaseStorage.ref().child('images').child(id);
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload menu function
  uploadMenu({
    required String foodname,
    required String foodDescription,
    required String imagePath,
    required String foodPrice,
    required String cuisine,
    required String category,
    required String location,
    required String mall,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();

      //get id
      var allDocs = await firebaseFirestore.collection('menus').get();
      int len = allDocs.docs.length;
      String imageUrl =
          await _uploadMenuToStorage(id: "Image $len", imagePath: imagePath);

      Menu menu = Menu(
        vendorName: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        id: "Menu $len",
        foodname: foodname,
        imageUrl: imageUrl,
        foodDescription: foodDescription,
        foodPrice: foodPrice,
        cuisine: cuisine,
        category: category,
        buyCount: 0,
        profilePhoto:
            (userDoc.data()! as Map<String, dynamic>)['profilePicture'],
      );

      await firebaseFirestore.collection("menus").doc('Menu $len').set(
            menu.toJson(),
          );
      Get.back(); // see previous page
    } catch (e) {
      Get.snackbar("Error Adding Menu", e.toString());
    }
  }
}
