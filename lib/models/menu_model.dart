import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String vendorName;
  String uid;
  String id;
  String foodname;
  String foodDescription;
  String foodPrice;
  String cuisine;
  String category;
  String imageUrl;
  int buyCount;
  String profilePhoto;

  Menu({
    required this.vendorName,
    required this.uid,
    required this.id,
    required this.foodname,
    required this.imageUrl,
    required this.foodDescription,
    required this.foodPrice,
    required this.cuisine,
    required this.category,
    required this.buyCount,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "vendorName": vendorName,
        "uid": uid,
        "id": id,
        "foodname": foodname,
        "foodDescription": foodDescription,
        "foodPrice": foodPrice,
        "cuisine": cuisine,
        "category": category,
        "imageUrl": imageUrl,
        "buyCount": buyCount,
        "profilePhoto": profilePhoto,
      };

  static Menu fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Menu(
      vendorName: snapshot['vendorName'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      foodname: snapshot['foodname'],
      foodDescription: snapshot['foodDescription'],
      foodPrice: snapshot['foodPrice'],
      cuisine: snapshot['cuisine'],
      category: snapshot['category'],
      imageUrl: snapshot['imageUrl'],
      buyCount: snapshot['buyCount'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
