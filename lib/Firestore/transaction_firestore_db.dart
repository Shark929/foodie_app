import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/transaction_model.dart';

class TransactionFirestoreDb {
  //create
  static addTransaction(TransactionModel transactionModel) async {
    await firebaseFirestore.collection('customerTransactions').add({
      'amount': transactionModel.amount,
      'code': transactionModel.code,
      'date': transactionModel.date,
      'uid': transactionModel.uid,
    });
  }

  //read

  static Stream<List<TransactionModel>> transactionStream() {
    return firebaseFirestore
        .collection('customerTransactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<TransactionModel> transactions = [];

      for (var transaction in querySnapshot.docs) {
        final transactionModel = TransactionModel.fromDocumentSnapshot(
            documentSnapshot: transaction);
        transactions.add(transactionModel);
      }
      return transactions;
    });
  }
  //update

  //delete
}
