import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';

import '../models/mall_model.dart';

class MallFirestoreDb {
  //add function
  static addmall(MallModel mallModel) async {
    await firebaseFirestore.collection('malls').add({
      'mall': mallModel.mall,
      'location': mallModel.location,
    });
  }

  //get function
  static Stream<List<MallModel>> mallStream() {
    return firebaseFirestore
        .collection('malls')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MallModel> malls = [];
      for (var mall in querySnapshot.docs) {
        final locationModel = MallModel.fromDocumentSnapshot(mall);

        malls.add(locationModel);
      }

      return malls;
    });
  }

  //update function

  //delete function
  static deleteLocation(String locationId) {
    firebaseFirestore.collection('malls').doc(locationId).delete();
  }
}
