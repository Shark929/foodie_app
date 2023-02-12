
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/models/promotion_model.dart';

import '../constants/constant.dart';

class PromotionFirestoreDb {

  //read
  static Stream<List<PromotionModel>> promotionStream() {
    return firebaseFirestore
        .collection('promotion')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<PromotionModel> promotions = [];

      for (var promotion in querySnapshot.docs) {
        final promotionModel =
            PromotionModel.documentSnapshot(documentSnapshot: promotion);

        promotions.add(promotionModel);
      }

      return promotions;
    });
  }
  //update

  //delete

  static deletePromotion(String documentId) {
    firebaseFirestore.collection('promotion').doc(documentId).delete();
  }
}
