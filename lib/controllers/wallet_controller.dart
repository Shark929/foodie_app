import 'package:foodie_app/Firestore/wallet_firestore_db.dart';
import 'package:foodie_app/models/wallet_model.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  Rx<List<WalletModel>> walletList = Rx<List<WalletModel>>([]);
  List<WalletModel> get wallet => walletList.value;

  @override
  void onReady() {
    walletList.bindStream(WalletFirestoreDb.walletStream());
  }
}
