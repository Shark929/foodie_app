import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/add_to_my_cart_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:foodie_app/models/my_cart_model.dart';
import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:get/get.dart';

class AddToCartScreen extends StatefulWidget {
  final ItemModel item;
  const AddToCartScreen({super.key, required this.item});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int quantity = 1;
  var customizationList = [];
  String getCustomization = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add to cart",
        ),
        elevation: 0,
        backgroundColor: buttonColor,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  widget.item.itemDescription,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  "RM ${widget.item.itemPrice}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonColor,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: buttonColor, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (quantity < 100) {
                      setState(() {
                        quantity++;
                      });
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          /**
           * Customization
           */

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: custom.length,
                itemBuilder: (context, index) {
                  if (custom[index]['id'] == widget.item.itemCategory) {
                    if (customizationList.isEmpty ||
                        customizationList.length < custom.length) {
                      customizationList.add(false);
                    }
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                customizationList[index] =
                                    !customizationList[index];

                                getCustomization =
                                    custom[index]['custom'].toString();
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: customizationList[index] == true
                                  ? const Icon(Icons.check)
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(custom[index]['custom'].toString()),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                double totalPrice =
                    double.parse(widget.item.itemPrice) * quantity;
                final myCartModel = MyCartModel(
                  itemPicture: widget.item.itemPicture,
                  customization: getCustomization,
                  itemDescription: widget.item.itemDescription,
                  itemName: widget.item.itemName,
                  itemPrice: widget.item.itemPrice,
                  quantity: quantity,
                  customerId: authController.user.uid,
                  totalPrice: totalPrice.toStringAsFixed(2),
                  vendorId: widget.item.vendorId,
                );
                AddToMyCartFirestoreDb.addToMyCart(myCartModel);
                Get.to(() => const UserHomeScreen());
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
          ),
        ]),
      ),
    ));
  }
}
