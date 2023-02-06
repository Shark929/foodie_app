import 'package:foodie_app/Firestore/vendor_firestore_db.dart';
import 'package:foodie_app/models/vendor_model.dart';
import 'package:get/get.dart';

class Vendor2Controller extends GetxController {
  Rx<List<Vendor2Model>> vendorList = Rx<List<Vendor2Model>>([]);

  List<Vendor2Model> get vendor => vendorList.value;

  @override
  void onReady() {
    vendorList.bindStream(Vendor2FirestoreDb.vendor2Stream());
  }
}
