import 'package:cloud_firestore/cloud_firestore.dart';

class MallModel {
  String? mallId;
  late String mall;
  late String location;

  MallModel({
    required this.mall,
    required this.location,
  });

  MallModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    mallId = documentSnapshot.id;
    mall = documentSnapshot['mall'];
    location = documentSnapshot['location'];
  }
}
