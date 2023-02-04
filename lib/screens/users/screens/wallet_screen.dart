import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/transaction_firestore_db.dart';
import 'package:foodie_app/Firestore/wallet_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/transaction_controller.dart';
import 'package:foodie_app/controllers/wallet_controller.dart';
import 'package:foodie_app/models/transaction_model.dart';
import 'package:foodie_app/models/wallet_model.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class UserWalletScreen extends StatelessWidget {
  final String id;
  UserWalletScreen({super.key, required this.id});

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: buttonColor,
        title: const Text("Wallet"),
      ),
      body: GetX<WalletController>(
          init: Get.put(WalletController()),
          builder: (WalletController wlController) {
            for (int i = 0; i < wlController.wallet.length; i++) {
              final wallet0 = wlController.wallet[i];
              if (authController.user.uid == wallet0.userId) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset("assets/qr.png"),
                        const SizedBox(
                          height: 30,
                        ),
                        GetX<WalletController>(
                            init: Get.put(WalletController()),
                            builder: (WalletController walletController) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: walletController.wallet.length,
                                  itemBuilder: (context, index) {
                                    final wallet0 =
                                        walletController.wallet[index];
                                    if (wallet0.userId ==
                                        authController.user.uid) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => SimpleDialog(
                                                          children: [
                                                            const SimpleDialogOption(
                                                              child: Text(
                                                                "Top up",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 16,
                                                                vertical: 20,
                                                              ),
                                                              child: TextField(
                                                                controller:
                                                                    amountController,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "RM 0.00"),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 16,
                                                              ),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  double newBalance = double.parse(
                                                                          wallet0
                                                                              .balance) +
                                                                      double.parse(
                                                                          amountController
                                                                              .text);
                                                                  final walletModel = WalletModel(
                                                                      balance: newBalance
                                                                          .toStringAsFixed(
                                                                              2),
                                                                      userId: authController
                                                                          .user
                                                                          .uid);
                                                                  WalletFirestoreDb
                                                                      .addWallet(
                                                                          walletModel);
                                                                  final transactionModel = TransactionModel(
                                                                      date: Timestamp.fromDate(
                                                                          DateTime
                                                                              .now()),
                                                                      amount: double.parse(amountController
                                                                              .text)
                                                                          .toStringAsFixed(
                                                                              2),
                                                                      code: 1,
                                                                      uid: authController
                                                                          .user
                                                                          .uid);

                                                                  TransactionFirestoreDb
                                                                      .addTransaction(
                                                                          transactionModel);

                                                                  //clear and close showDialog
                                                                  amountController
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    "Confirm"),
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                          },
                                          child: Container(
                                            height: 100,
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                32,
                                            decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  "Foodie Wallet",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Text("Balance"),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "RM ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          double.parse(wallet0
                                                                  .balance)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    const Text("Top up"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text(
                              "Transactions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        GetX<TransactionController>(
                            init: Get.put(TransactionController()),
                            builder:
                                (TransactionController transactionController) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      transactionController.transaction.length,
                                  itemBuilder: (context, index) {
                                    final tran0 = transactionController
                                        .transaction[index];

                                    if (authController.user.uid == tran0.uid) {
                                      return ListTile(
                                        title: Text(tran0.code == 1
                                            ? "Top up"
                                            : tran0.code == 2
                                                ? "Foodie"
                                                : "Refunded"),
                                        subtitle: Text(
                                          tago.format(DateTime.parse(
                                              tran0.date.toDate().toString())),
                                        ),
                                        trailing: Text(
                                          "RM ${tran0.amount}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  });
                            }),
                      ],
                    ),
                  ),
                );
              }
            }
            return Center(
                child: InkWell(
              onTap: () {
                final walletModel =
                    WalletModel(balance: "0", userId: authController.user.uid);
                WalletFirestoreDb.addWallet(walletModel);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Create wallet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ));
          }),
    );
  }
}
