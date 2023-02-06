import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor2Model {
  String? vendorId;
  late String vendorRestaurantName;
  late String vendorPhone;
  late String vendorEmail;
  late String vendorLocation;
  late String vendorMall;
  late String vendorImage;
  late bool isAuthorise;
  late bool isOpen;
  late String openHour;
  late String closeHour;

  Vendor2Model({
    this.vendorId,
    required this.vendorRestaurantName,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.vendorLocation,
    required this.vendorMall,
    required this.vendorImage,
    required this.isAuthorise,
    required this.isOpen,
    required this.openHour,
    required this.closeHour,
  });

  Vendor2Model.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    vendorId = documentSnapshot['vendorId'];
    vendorRestaurantName = documentSnapshot['vendorRestaurantName'];
    vendorEmail = documentSnapshot['vendorEmail'];
    vendorPhone = documentSnapshot['vendorPhone'];
    vendorLocation = documentSnapshot['vendorLocation'];
    vendorMall = documentSnapshot['vendorMall'];
    vendorImage = documentSnapshot['vendorImage'];
    isAuthorise = documentSnapshot['isAuthorise'];
    isOpen = documentSnapshot['isOpen'];
    openHour = documentSnapshot['openHour'];
    closeHour = documentSnapshot['closeHour'];
  }
}
