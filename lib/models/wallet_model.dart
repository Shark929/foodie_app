import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  String? walletBalanceId;
  // late Timestamp date;
  late String balance;
  late String userId;

  WalletModel({required this.balance, required this.userId});

  WalletModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    walletBalanceId = documentSnapshot.id;
    // date = documentSnapshot['date'];
    balance = documentSnapshot['balance'];
    userId = documentSnapshot['userId'];
  }
}
