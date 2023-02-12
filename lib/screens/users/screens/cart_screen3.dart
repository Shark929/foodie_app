import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/add_to_my_cart_firestore_db.dart';
import 'package:foodie_app/Firestore/order_firestore_db.dart';
import 'package:foodie_app/Firestore/transaction_firestore_db.dart';
import 'package:foodie_app/Firestore/wallet_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/add_to_cart_controller.dart';
import 'package:foodie_app/controllers/get_order_number_controller.dart';
import 'package:foodie_app/controllers/promotion_controller.dart';
import 'package:foodie_app/controllers/wallet_controller.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:foodie_app/models/order_model.dart';
import 'package:foodie_app/models/transaction_model.dart';
import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:foodie_app/widgets/slide_menu.dart';
import 'package:get/get.dart';

class CartScreen3 extends StatefulWidget {
  const CartScreen3({super.key});

  @override
  State<CartScreen3> createState() => _CartScreen3State();
}

class _CartScreen3State extends State<CartScreen3> {
  bool isDineIn = true;
  TextEditingController promotionController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  Random random = Random();
  String hour = "00";
  String minute = "00";
  bool checkPromotion = false;
  late String vendorId;
  @override
  Widget build(BuildContext context) {
    double initalTotalPrice = 0.0;
    double promotinPercentage = 0.0;
    List<MyCartModel> mycart = [];
    List getCartId = [];
    double myWalletBalance = 0.0;
    final numController = Get.put(GetOrderNumberController());
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: buttonColor,
              title: const Text("Cart"),
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Column(children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 100,
                                  ),
                                  const Text(
                                    "Confirm cancel all?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: buttonColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: GetX<AddToMyCartController>(
                init: Get.put(AddToMyCartController()),
                builder: (AddToMyCartController atmcController) {
                  var checkUserCart = [];
                  for (int i = 0; i < atmcController.myCart.length; i++) {
                    if (authController.user.uid ==
                        atmcController.myCart[i].customerId) {
                      if (checkUserCart.isEmpty ||
                          !checkUserCart.contains(authController.user.uid)) {
                        checkUserCart.add(authController.user.uid);
                      }
                    }
                  }

                  if (checkUserCart.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetX<WalletController>(
                                init: Get.put(WalletController()),
                                builder: (WalletController wcController) {
                                  for (int i = 0;
                                      i < wcController.wallet.length;
                                      i++) {
                                    if (wcController.wallet[i].userId ==
                                        authController.user.uid) {
                                      myWalletBalance = double.parse(
                                          wcController.wallet[i].balance);
                                    }
                                  }
                                  return const SizedBox();
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            //show added item in cart
                            GetX<AddToMyCartController>(
                                init: Get.put(AddToMyCartController()),
                                builder:
                                    (AddToMyCartController atmcController) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: atmcController.myCart.length,
                                      itemBuilder: (context, index) {
                                        final atmc =
                                            atmcController.myCart[index];
                                        var totalPriceList = [];
                                        mycart
                                            .add(atmcController.myCart[index]);
                                        if (authController.user.uid ==
                                            atmc.customerId) {
                                          if (totalPriceList.isEmpty ||
                                              totalPriceList.length <
                                                  atmcController
                                                      .myCart.length) {
                                            totalPriceList.add(atmc.totalPrice);
                                          }

                                          for (int i = 0;
                                              i < totalPriceList.length;
                                              ++i) {
                                            initalTotalPrice +=
                                                double.parse(totalPriceList[i]);
                                          }

                                          if (getCartId.isEmpty ||
                                              getCartId.length <
                                                  atmcController
                                                      .myCart.length) {
                                            getCartId.add(atmc.myCartId);
                                          }
                                          vendorId = atmc.vendorId;

                                          return SlideMenu(
                                              menuItems: [
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      AddToMyCartFirestoreDb
                                                          .deleteMyCart(
                                                              atmc.myCartId!);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              ],
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: ListTile(
                                                  leading: Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          atmc.itemPicture,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    atmc.itemName,
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("X${atmc.quantity}"),
                                                      Text(
                                                          "RM ${atmc.itemPrice}"),
                                                    ],
                                                  ),
                                                  trailing: Text(
                                                    "RM ${atmc.totalPrice}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        }
                                        return const SizedBox();
                                      });
                                }),
                            //dine in or take away
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Dine in or take away?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isDineIn = true;
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isDineIn ? buttonColor : null,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: buttonColor, width: 2),
                                    ),
                                    child: const Text("Dine In"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isDineIn = false;
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: !isDineIn ? buttonColor : null,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: buttonColor, width: 2),
                                    ),
                                    child: const Text("Take away"),
                                  ),
                                ),
                              ],
                            ),
                            //pick up time
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Please set your having time?",
                              style: TextStyle(
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
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: buttonColor,
                                      width: 2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    hour,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: buttonColor,
                                      width: 2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    minute,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: SizedBox(
                                                height: 300,
                                                width: 300,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: const Text(
                                                        "Set your time",
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color:
                                                                    buttonColor,
                                                                width: 2),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextField(
                                                            controller:
                                                                hourController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorHeight: 36,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        36),
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        hour,
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          36,
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color:
                                                                    buttonColor,
                                                                width: 2),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextField(
                                                            controller:
                                                                minuteController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorHeight: 36,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        36),
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        minute,
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          36,
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (hourController
                                                                    .text !=
                                                                "" &&
                                                            minuteController
                                                                    .text !=
                                                                "") {
                                                          setState(() {
                                                            hour =
                                                                hourController
                                                                    .text;
                                                            minute =
                                                                minuteController
                                                                    .text;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child:
                                                          const Text("Confirm"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: const Text("Set time"),
                                ),
                              ],
                            ),

                            //apply promotion
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Do you have any promotion code?",
                              style: TextStyle(
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
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.only(left: 16),
                                    width: 200,
                                    child: TextField(
                                      controller: promotionController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter promotion code",
                                      ),
                                    )),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      checkPromotion = !checkPromotion;
                                    });
                                  },
                                  child: const Text("Apply"),
                                ),
                              ],
                            ),
                            //get Promotion
                            checkPromotion == true
                                ? GetX<PromotionController>(
                                    init: Get.put(PromotionController()),
                                    builder: (PromotionController pController) {
                                      for (int i = 0;
                                          i < pController.promotion.length;
                                          i++) {
                                        if (promotionController.text ==
                                            pController
                                                .promotion[i].promotionCode) {
                                          promotinPercentage = double.parse(
                                                  pController.promotion[i]
                                                      .promotionPercentage) /
                                              100;
                                        }
                                      }
                                      return const SizedBox();
                                    })
                                : const SizedBox(),

                            //proceed to payment
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                //total price is already calculated
                                print(initalTotalPrice.toStringAsFixed(2));

                                //is dine in?
                                print(isDineIn);

                                //time
                                print("$hour:$minute");

                                //generate random number for order number
                                int randomNumber = random.nextInt(1000);
                                print(randomNumber);

                                //promotion code
                                print(promotinPercentage);

                                //my cart
                                print(mycart);

                                if (myWalletBalance > initalTotalPrice) {
                                  if (promotinPercentage != 0.0) {
                                    double newTotal = initalTotalPrice -
                                        (initalTotalPrice * promotinPercentage);

                                    myWalletBalance =
                                        myWalletBalance - newTotal;
                                    WalletFirestoreDb.updateAmount(
                                        myWalletBalance.toStringAsFixed(2),
                                        authController.user.uid);

                                    final transactionModel = TransactionModel(
                                        date:
                                            Timestamp.fromDate(DateTime.now()),
                                        amount: newTotal.toStringAsFixed(2),
                                        code: 2,
                                        uid: authController.user.uid);
                                    TransactionFirestoreDb.addTransaction(
                                        transactionModel);
                                    final orderModel = OrderModel(
                                        customerId: authController.user.uid,
                                        isDineIn: isDineIn,
                                        code: "1",
                                        orderNumber: randomNumber.toString(),
                                        time: "$hour:$minute",
                                        totalPrice: newTotal.toStringAsFixed(2),
                                        vendorId: vendorId);
                                    OrderFirestoreDb.addToOrder(orderModel);
                                  } else {
                                    myWalletBalance =
                                        myWalletBalance - initalTotalPrice;

                                    final transactionModel = TransactionModel(
                                        date:
                                            Timestamp.fromDate(DateTime.now()),
                                        amount:
                                            initalTotalPrice.toStringAsFixed(2),
                                        code: 2,
                                        uid: authController.user.uid);
                                    TransactionFirestoreDb.addTransaction(
                                        transactionModel);
                                    WalletFirestoreDb.updateAmount(
                                        myWalletBalance.toStringAsFixed(2),
                                        authController.user.uid);
                                    final orderModel = OrderModel(
                                        customerId: authController.user.uid,
                                        isDineIn: isDineIn,
                                        code: "1",
                                        orderNumber: randomNumber.toString(),
                                        time: "$hour:$minute",
                                        totalPrice:
                                            initalTotalPrice.toStringAsFixed(2),
                                        vendorId: vendorId);
                                    OrderFirestoreDb.addToOrder(orderModel);
                                  }

                                  numController
                                      .setNumber(randomNumber.toString());
                                  for (var e in mycart) {
                                    OrderFirestoreDb.addOrderList(
                                        randomNumber.toString(), e);
                                  }

                                  for (var e in getCartId) {
                                    AddToMyCartFirestoreDb.deleteMyCart(e);
                                  }

                                  Get.to(() => const UserHomeScreen());
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: SizedBox(
                                              height: 300,
                                              width: 300,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: const [
                                                  Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                    size: 50,
                                                  ),
                                                  Text(
                                                    "Insufficient balance!",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                }
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
                                    "Proceed payment",
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
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Empty cart"),
                    );
                  }
                })));
  }
}
