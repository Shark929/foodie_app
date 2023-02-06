import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/location_model.dart';

class LocationFirestoreDb {
  //add function
  static addLocation(LocationModel locationModel) async {
    await firebaseFirestore.collection('location').add({
      'locationName': locationModel.locationName,
    });
  }

  //get function
  static Stream<List<LocationModel>> locationStream() {
    return firebaseFirestore
        .collection('location')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<LocationModel> locations = [];
      for (var location in querySnapshot.docs) {
        final locationModel =
            LocationModel.fromDocumentSnapshot(documentSnapshot: location);

        locations.add(locationModel);
      }

      return locations;
    });
  }

  //update function
}
