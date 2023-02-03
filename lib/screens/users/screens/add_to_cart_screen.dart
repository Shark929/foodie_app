import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/cart_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/cart_controller.dart';
import 'package:foodie_app/models/cart_model2.dart';
import 'package:foodie_app/models/menu_model.dart';

import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:get/get.dart';

class AddToCartScreen extends StatefulWidget {
  final ItemModel item;
  const AddToCartScreen({super.key, required this.item});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final isCheck = [];
  int quantity = 1;
  String customization = "";
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    cartController.updateId(
      id: authController.user.uid,
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.item.itemPicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.item.itemName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.item.itemDescription,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "RM ${double.parse(widget.item.itemPrice).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: buttonColor),
                      alignment: Alignment.center,
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (quantity < 100) {
                          setState(() {
                            quantity++;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Divider(
                thickness: 1.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Customization",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: custom.length,
                itemBuilder: (context, index) {
                  if (custom[index]['id'] == widget.item.itemCategory) {
                    isCheck.add(false);
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isCheck[index] = !isCheck[index];
                                customization =
                                    custom[index]['custom'].toString();
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: isCheck[index]
                                  ? const Icon(
                                      Icons.check,
                                      color: buttonColor,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            custom[index]['custom'].toString(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Random random = new Random();
                int randomNumber = random.nextInt(1000);
                //add to cart
                final cartModel2 = CartModel2(
                  // cartId: randomNumber.toString(),
                  username: '',
                  quantity: quantity,
                  customization: customization,
                  uid: authController.user.uid,
                  code: "1",
                  foodName: widget.item.itemName,
                  foodPic: widget.item.itemPicture,
                  foodPrice: double.parse(widget.item.itemPrice),
                  vendorId: widget.item.vendorId,
                  pickupTime: '',
                  isDineIn: true,
                );
                CartFirestore.addCart(cartModel2);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserHomeScreen()),
                    (route) => false);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Add to cart",
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
        )),
      ),
    );
  }
}
