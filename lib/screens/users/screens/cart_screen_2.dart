import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/cart_firestore_db.dart';
import 'package:foodie_app/Firestore/order_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/cart_controller2.dart';
import 'package:foodie_app/models/cart_model2.dart';
import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:get/get.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({super.key});

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  TimeOfDay setTime = const TimeOfDay(hour: 10, minute: 30);
  String isDineIn = "1";
  String documentId = "";
  List<CartModel2> vendorCart = [];
  List documentIdList = [];
  @override
  Widget build(BuildContext context) {
    final hours = setTime.hour.toString().padLeft(2, '0');
    final minutes = setTime.minute.toString().padLeft(2, '0');
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
            GetX<CartController2>(
                init: Get.put(CartController2()),
                builder: (CartController2 cartController2) {
                  if (cartController2.cart.isEmpty) {
                    return const Center(child: Text("Empty cart"));
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
                                            hours,
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
                                            minutes,
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
                                      vendorCart.clear();
                                      documentIdList.clear();

                                      for (var docEle in documentIdList) {
                                        CartFirestore.updateTime(
                                            "${newTime.hour}: ${newTime.minute}",
                                            docEle);
                                      }
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
                                  //add to cart

                                  for (var ele in vendorCart) {
                                    OrderFirestoreDb.addToVendorCart(ele);
                                  }

                                  for (var docEle in documentIdList) {
                                    CartFirestore.deleteCart(docEle);
                                  }

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserHomeScreen()),
                                      (route) => false);
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
