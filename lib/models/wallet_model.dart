import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  String username;
  String amount;
  final date;
  List transactions;
  String uid;
  String id;
  String code;

  WalletModel({
    required this.username,
    required this.amount,
    required this.date,
    required this.transactions,
    required this.uid,
    required this.id,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'amount': amount,
        'dateTopup': date,
        'transactions': transactions,
        'uid': uid,
        'id': id,
        'code': code,
      };

  static WalletModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return WalletModel(
      username: snapshot['username'],
      amount: snapshot['amount'],
      date: snapshot['dateTopup'],
      transactions: snapshot['transactions'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      code: snapshot['code'],
    );
  }
}
