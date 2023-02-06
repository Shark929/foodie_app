import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/cart_firestore_db.dart';
import 'package:foodie_app/Firestore/order_firestore.dart';
import 'package:foodie_app/Firestore/transaction_firestore_db.dart';
import 'package:foodie_app/Firestore/wallet_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/cart_controller2.dart';
import 'package:foodie_app/controllers/wallet_controller.dart';
import 'package:foodie_app/models/cart_model2.dart';
import 'package:foodie_app/models/transaction_model.dart';
import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({super.key});

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  TimeOfDay setTime = const TimeOfDay(hour: 10, minute: 30);
  String isDineIn = "1";
  String documentId = "";
  String hours = "";
  String minutes = "";
  List<CartModel2> vendorCart = [];
  List transaction = [];
  List documentIdList = [];
  double myWalletBalance = 0.0;

  _launchURL() async {
    const url =
        'https://www2.pbebank.com/myIBK/apppbb/servlet/BxxxServlet?RDOName=BxxxAuth&MethodName=login';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // hours = setTime.hour.toString().padLeft(2, '0');
    // minutes = setTime.minute.toString().padLeft(2, '0');

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: const Text("Cart"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetX<WalletController>(
                init: Get.put(WalletController()),
                builder: (WalletController walletController) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: walletController.wallet.length,
                    itemBuilder: (context, index) {
                      final walley0 = walletController.wallet[index];
                      if (walley0.userId == authController.user.uid) {
                        myWalletBalance = double.parse(walley0.balance);
                        return const SizedBox();
                      }
                      return const SizedBox();
                    },
                  );
                }),
            GetX<CartController2>(
                init: Get.put(CartController2()),
                builder: (CartController2 cartController2) {
                  if (cartController2.cart.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 300,
                        ),
                        Text("Empty cart"),
                      ],
                    ));
                  } else {
                    return Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cartController2.cart.length,
                              itemBuilder: (context, index) {
                                final cartModel0 = cartController2.cart[index];
                                documentId = cartModel0.cartId!;
                                var totalPrice =
                                    cartModel0.quantity * cartModel0.foodPrice;
                                if (vendorCart.isEmpty ||
                                    vendorCart.length <
                                        cartController2.cart.length) {
                                  vendorCart.add(cartModel0);
                                }

                                if (documentIdList.isEmpty ||
                                    documentIdList.length <
                                        cartController2.cart.length) {
                                  documentIdList.add(cartModel0.cartId);
                                }

                                if (transaction.isEmpty ||
                                    transaction.length <
                                        cartController2.cart.length) {
                                  transaction.add(totalPrice);
                                }
                                return ListTile(
                                  leading: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            cartModel0.foodPic,
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  title: Text(cartModel0.foodName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(cartModel0.customization),
                                      Text("X ${cartModel0.quantity}"),
                                      Text(
                                          "RM ${cartModel0.foodPrice.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                  trailing: Text(
                                    "RM ${totalPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isDineIn = "0";
                                          });
                                          for (var docEle in documentIdList) {
                                            CartFirestore.updateDineIn(
                                                false, docEle);
                                          }
                                          vendorCart.clear();
                                          documentIdList.clear();
                                        },
                                        child: Container(
                                          height: 80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          decoration: BoxDecoration(
                                              color: isDineIn == "0"
                                                  ? buttonColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: buttonColor,
                                              )),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Take away",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isDineIn = "1";
                                          });
                                          for (var docEle in documentIdList) {
                                            CartFirestore.updateDineIn(
                                                true, docEle);
                                          }
                                          vendorCart.clear();
                                          documentIdList.clear();
                                        },
                                        child: Container(
                                          height: 80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          decoration: BoxDecoration(
                                              color: isDineIn == "1"
                                                  ? buttonColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: buttonColor,
                                              )),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Dine in",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                isDineIn == "0"
                                    ? "Set take away time"
                                    : "Set dine in time",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(
                                            setTime.hour
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            ":",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(
                                            setTime.minute
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                buttonColor)),
                                    onPressed: () async {
                                      TimeOfDay? newTime = await showTimePicker(
                                          context: context,
                                          initialTime: setTime);
                                      if (newTime == null) {
                                        return;
                                      }
                                      setState(() {
                                        setTime = newTime;
                                      });
                                      for (var docEle in documentIdList) {
                                        CartFirestore.updateTime(
                                            "${setTime.hour.toString().padLeft(2, '0')}: ${setTime.minute.toString().padLeft(2, '0')}",
                                            docEle);
                                      }
                                      vendorCart.clear();
                                      documentIdList.clear();

                                      // for (var docEle in documentIdList) {
                                      //   CartFirestore.updateTime(
                                      //       "${setTime.hour}: ${setTime.minute}",
                                      //       docEle);
                                      // }
                                    },
                                    child: const Text("Set time"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Text(
                                                    "Payment method",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          //calculate total payment

                                                          double totalPayment =
                                                              0;
                                                          for (var ele
                                                              in transaction) {
                                                            totalPayment += ele;
                                                          }
                                                          //add to cart

                                                          //update wallet balance

                                                          if (myWalletBalance <
                                                              totalPayment) {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Dialog(
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                200,
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: const [
                                                                                Icon(
                                                                                  Icons.error,
                                                                                  size: 100,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                Text(
                                                                                  "Insufficient balance",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ));
                                                          } else {
                                                            for (var ele
                                                                in vendorCart) {
                                                              OrderFirestoreDb
                                                                  .addToVendorCart(
                                                                      ele);
                                                            }

                                                            for (var docEle
                                                                in documentIdList) {
                                                              CartFirestore
                                                                  .deleteCart(
                                                                      docEle);
                                                            }

                                                            final transactionModel = TransactionModel(
                                                                date: Timestamp
                                                                    .fromDate(
                                                                        DateTime
                                                                            .now()),
                                                                amount: totalPayment
                                                                    .toStringAsFixed(
                                                                        2),
                                                                code: 2,
                                                                uid:
                                                                    authController
                                                                        .user
                                                                        .uid);
                                                            TransactionFirestoreDb
                                                                .addTransaction(
                                                                    transactionModel);
                                                            double
                                                                updateMyBalance =
                                                                myWalletBalance -
                                                                    totalPayment;

                                                            WalletFirestoreDb
                                                                .updateAmount(
                                                                    updateMyBalance
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    authController
                                                                        .user
                                                                        .uid);

                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const UserHomeScreen()),
                                                                (route) =>
                                                                    false);
                                                          }
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 120,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  buttonColor),
                                                          child: const Text(
                                                            "Pay now",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: _launchURL,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 120,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: buttonColor,
                                                          ),
                                                          child: const Text(
                                                            "Pay online",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // margin:
                                  //     const EdgeInsets.symmetric(horizontal: 16),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Order now",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    ));
  }
}
