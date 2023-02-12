import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartModel {
  late String itemName;
  late String customerId;
  late String itemDescription;
  late String customization;
  late String itemPicture;
  late int quantity;
  late String totalPrice;
  late String itemPrice;
  late String vendorId;
  String? myCartId;

  MyCartModel({
    required this.customization,
    required this.itemPicture,
    required this.itemDescription,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.totalPrice,
    required this.customerId,
    required this.vendorId,
  });

  MyCartModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    myCartId = documentSnapshot.id;
    customization = documentSnapshot['customization'];
    itemPicture = documentSnapshot['itemPicture'];
    itemDescription = documentSnapshot['itemDescription'];
    itemName = documentSnapshot['itemName'];
    itemPrice = documentSnapshot['itemPrice'];
    totalPrice = documentSnapshot['totalPrice'];
    quantity = documentSnapshot['quantity'];
    customerId = documentSnapshot['customerId'];
    vendorId = documentSnapshot['vendorId'];
  }
}
