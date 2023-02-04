import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/wallet_model.dart';

class WalletFirestoreDb {
  //create
  static addWallet(WalletModel walletModel) async {
    await firebaseFirestore
        .collection('userWalletBalance')
        .doc(authController.user.uid)
        .set({
      'balance': walletModel.balance,
      'userId': walletModel.userId,
    });
  }

  //read
  static Stream<List<WalletModel>> walletStream() {
    return firebaseFirestore
        .collection('userWalletBalance')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<WalletModel> wallets = [];
      for (var wallet in querySnapshot.docs) {
        final walletModel = WalletModel.fromDocumentSnapshot(wallet);
        wallets.add(walletModel);
      }
      return wallets;
    });
  }
  //update
  //update amount

  static updateAmount(String newBalance, documentId) {
    firebaseFirestore.collection('userWalletBalance').doc(documentId).update(
      {
        'balance': newBalance,
      },
    );
  }
  //delete
}
