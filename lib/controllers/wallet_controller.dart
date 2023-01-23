import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/wallet_model.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final Rx<List<WalletModel>> _wallets = Rx<List<WalletModel>>([]);
  List<WalletModel> get wallet => _wallets.value;

  String _walletId = "";

  updateId({required String id}) {
    _walletId = id;
    getWallet();
  }

  getWallet() async {
    _wallets.bindStream(firebaseFirestore
        .collection('wallets')
        .doc(_walletId)
        .collection('transactions')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<WalletModel> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(WalletModel.fromSnap(element));
      }
      return returnValue;
    }));
  }

  postWallet({
    required double amount,
    required String code,
  }) async {
    try {
      if (amount.toStringAsFixed(2).isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseFirestore
            .collection('users')
            .doc(authController.user.uid)
            .get();

        var allDocs = await firebaseFirestore
            .collection('wallets')
            .doc(authController.user.uid)
            .collection('transactions')
            .get();

        int length = allDocs.docs.length;

        WalletModel wallet = WalletModel(
          username: (userDoc.data()! as dynamic)['username'],
          amount: amount.toStringAsFixed(2),
          date: DateTime.now(),
          transactions: [],
          uid: authController.user.uid,
          id: "Wallet $length",
          code: code,
        );

        await firebaseFirestore
            .collection('wallets')
            .doc(_walletId)
            .collection('transactions')
            .doc('Wallet $length')
            .set(wallet.toJson());

        DocumentSnapshot docSnap = await firebaseFirestore
            .collection('transactions')
            .doc(_walletId)
            .get();
        // firebaseFirestore.collection('wallets').doc(_walletId).update({

        // });
      }
    } catch (e) {
      Get.snackbar("Wallet Error", e.toString());
    }
  }
}
