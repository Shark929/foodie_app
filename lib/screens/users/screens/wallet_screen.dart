import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/wallet_controller.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class UserWalletScreen extends StatelessWidget {
  final String id;
  UserWalletScreen({super.key, required this.id});

  final TextEditingController amountController = TextEditingController();
  WalletController walletController = Get.put(WalletController());
  showOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                const SimpleDialogOption(
                  child: Text(
                    "Top up",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: TextField(
                    controller: amountController,
                    decoration: const InputDecoration(hintText: "RM 0.00"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: () => walletController.postWallet(
                      amount: double.parse(amountController.text),
                      code: "1", //top up
                    ),
                    child: const Text("Confirm"),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    walletController.updateId(id: id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: buttonColor,
        title: const Text("Wallet"),
      ),
      body: SingleChildScrollView(
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
              GestureDetector(
                onTap: () => showOptionDialog(context),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            children: const [
                              Text(
                                "RM ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "20.00",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
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
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width - 32,
                child: Obx(() {
                  return ListView.builder(
                      itemCount: walletController.wallet.length,
                      itemBuilder: (context, index) {
                        final transaction = walletController.wallet[index];
                        return ListTile(
                          leading: Image.asset(transaction.code == "1"
                              ? "assets/top-up.png"
                              : ""),
                          title: Text(transaction.code == "1" ? "Top up" : ""),
                          subtitle:
                              Text(tago.format(transaction.date.toDate())),
                          trailing: Text(
                            "RM ${transaction.amount}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
