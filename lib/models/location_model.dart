import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  String? locationId;
  late String locationName;

  LocationModel({
    this.locationId,
    required this.locationName,
  });

  LocationModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    locationId = documentSnapshot.id;
    locationName = documentSnapshot['locationName'];
  }
}
