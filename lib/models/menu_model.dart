import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemId;
  late String itemName;
  late String itemPrice;
  late String itemDescription;
  late String itemCategory;
  late String itemPicture;
  late String itemCuisineType;
  late String uid;
  late bool availabilityCode;
  late String vendorId;

  ItemModel({
    this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.itemCategory,
    required this.itemPicture,
    required this.itemCuisineType,
    required this.uid,
    required this.availabilityCode,
    required this.vendorId,
  });

  ItemModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    itemId = documentSnapshot.id;
    itemName = documentSnapshot['itemName'];
    itemPrice = documentSnapshot['itemPrice'];
    itemDescription = documentSnapshot['itemDescription'];
    itemCategory = documentSnapshot['itemCategory'];
    itemPicture = documentSnapshot['itemPicture'];
    itemCuisineType = documentSnapshot['itemCuisineType'];
    uid = documentSnapshot['uid'];
    availabilityCode = documentSnapshot['availabilityCode'];
    vendorId = documentSnapshot['vendorId'];
  }
}
