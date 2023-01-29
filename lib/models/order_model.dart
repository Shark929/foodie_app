import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/cart_model.dart';

class OrderModel {
  String uid;
  String id;
  String vendorName;
  List totalPrice;
  List prices;
  List items;
  List quantities;

  OrderModel({
    required this.uid,
    required this.id,
    required this.vendorName,
    required this.totalPrice,
    required this.prices,
    required this.items,
    required this.quantities,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'vendorName': vendorName,
        'totalPrice': totalPrice,
        'prices': prices,
        'items': items,
        'quantities': quantities,
      };

  static OrderModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return OrderModel(
      uid: snapshot['uid'],
      id: snapshot['id'],
      vendorName: snapshot['vendorName'],
      totalPrice: snapshot['totalPrice'],
      prices: snapshot['prices'],
      items: snapshot['items'],
      quantities: snapshot['quantities'],
    );
  }
}
