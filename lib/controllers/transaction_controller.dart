import 'package:foodie_app/Firestore/transaction_firestore_db.dart';
import 'package:foodie_app/models/transaction_model.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Rx<List<TransactionModel>> transactionList = Rx<List<TransactionModel>>([]);

  List<TransactionModel> get transaction => transactionList.value;

  @override
  void onReady() {
    transactionList.bindStream(TransactionFirestoreDb.transactionStream());
  }
}
