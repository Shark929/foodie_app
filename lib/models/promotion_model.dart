import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  String? promotionId;
  late String promotionLabel;
  late String promotionPercentage;
  late String promotionDescription;
  late String promotionCode;
  // late Timestamp startDate;
  // late Timestamp endDate;

  PromotionModel({
    this.promotionId,
    required this.promotionLabel,
    required this.promotionPercentage,
    required this.promotionDescription,
    required this.promotionCode,
    // required this.startDate,
    // required this.endDate,
  });

  PromotionModel.documentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    promotionId = documentSnapshot.id;
    promotionLabel = documentSnapshot['promotionLabel'];
    promotionPercentage = documentSnapshot['promotionPercentage'];
    promotionDescription = documentSnapshot['promotionDescription'];
    promotionCode = documentSnapshot['promotionCode'];
    // startDate = documentSnapshot['startDate'];
    // endDate = documentSnapshot['endDate'];
  }
}
