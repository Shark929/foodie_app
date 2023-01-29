import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/cart_controller.dart';
import 'package:foodie_app/models/menu_model.dart';
import 'package:foodie_app/screens/users/screens/home_screen.dart';
import 'package:get/get.dart';

class AddToCartScreen extends StatefulWidget {
  final Menu menu;
  const AddToCartScreen({super.key, required this.menu});

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
                  image: NetworkImage(widget.menu.imageUrl),
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
                widget.menu.foodname,
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
                widget.menu.foodDescription,
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
                    "RM ${widget.menu.foodPrice}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: Row(children: [
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
                  ),
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
                  if (custom[index]['id'] == widget.menu.category) {
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
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  cartController.postCart(
                      customization: customization,
                      quantity: quantity,
                      menu: widget.menu);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserHomeScreen()),
                      (route) => false);
                },
                child: const Text("Add to cart"),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
