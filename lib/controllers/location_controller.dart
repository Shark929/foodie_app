import 'package:foodie_app/Firestore/location_firestore_db.dart';
import 'package:foodie_app/models/location_model.dart';
import 'package:get/get.dart';


class LocationController extends GetxController {
  Rx<List<LocationModel>> locationList = Rx<List<LocationModel>>([]);

  List<LocationModel> get location => locationList.value;

  @override
  void onReady() {
    locationList.bindStream(LocationFirestoreDb.locationStream());
  }
}
