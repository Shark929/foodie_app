import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String username;
  int quantity;
  String customization;
  String uid;
  String id;
  String code;
  String foodName;
  String vendorname;
  String foodPic;
  double foodPrice;

  CartModel({
    required this.username,
    required this.quantity,
    required this.customization,
    required this.uid,
    required this.id,
    required this.code,
    required this.foodName,
    required this.foodPic,
    required this.foodPrice,
    required this.vendorname,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'quantity': quantity,
        'customization': customization,
        'uid': uid,
        'id': id,
        'code': code,
        'foodName': foodName,
        'foodPic': foodPic,
        'foodPrice': foodPrice,
        'vendorname': vendorname,
      };

  static CartModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return CartModel(
      username: snapshot['username'],
      quantity: snapshot['quantity'],
      customization: snapshot['customization'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      code: snapshot['code'],
      foodName: snapshot['foodName'],
      foodPic: snapshot['foodPic'],
      foodPrice: snapshot['foodPrice'],
      vendorname: snapshot['vendorname'],
    );
  }
}
