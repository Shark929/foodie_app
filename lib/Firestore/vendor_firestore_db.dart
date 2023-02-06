import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/vendor_model.dart';

class Vendor2FirestoreDb {
  //create

  //read

  static Stream<List<Vendor2Model>> vendor2Stream() {
    return firebaseFirestore
        .collection('vendors')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Vendor2Model> vendors = [];

      for (var vendor in querySnapshot.docs) {
        final vendor2Model =
            Vendor2Model.fromDocumentSnapshot(documentSnapshot: vendor);
        vendors.add(vendor2Model);
      }
      return vendors;
    });
  }

  //update
  //update open or close shop
  static updateShop(bool isOpen, documentId) {
    firebaseFirestore.collection('vendors').doc(documentId).update(
      {
        'isOpen': isOpen,
      },
    );
  }

  //update open hour and close hour
  static updateOpenTime(String openHour, documentId) {
    firebaseFirestore.collection('vendors').doc(documentId).update(
      {
        'openHour': openHour,
      },
    );
  }

  static updateCloseTime(String closeHour, documentId) {
    firebaseFirestore.collection('vendors').doc(documentId).update(
      {
        'closeHour': closeHour,
      },
    );
  }
  //update location

  //update mall
  static updateLocationMall(String location, String mall, documentId) {
    firebaseFirestore.collection('vendors').doc(documentId).update(
      {
        'vendorLocation': location,
        'vendorMall': mall,
      },
    );
  }

  //update image
  static updateImage(String downloadUrl, documentId) {
    firebaseFirestore.collection('vendors').doc(documentId).update(
      {
        'vendorImage': downloadUrl,
      },
    );
  }
  //delete
}
