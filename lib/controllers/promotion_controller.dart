import 'package:foodie_app/Firestore/promotion_firestore_db.dart';
import 'package:foodie_app/models/promotion_model.dart';
import 'package:get/get.dart';

class PromotionController extends GetxController {
  Rx<List<PromotionModel>> promotionList = Rx<List<PromotionModel>>([]);

  List<PromotionModel> get promotion => promotionList.value;

  @override
  void onReady() {
    promotionList.bindStream(PromotionFirestoreDb.promotionStream());
  }
}
