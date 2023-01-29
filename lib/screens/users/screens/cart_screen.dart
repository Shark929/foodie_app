import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/cart_controller.dart';
import 'package:foodie_app/controllers/order_controller.dart';
import 'package:foodie_app/widgets/slide_menu.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  final String id;
  CartScreen({super.key, required this.id});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.put(CartController());
  OrderController orderController = Get.put(OrderController());
  TimeOfDay setTime = const TimeOfDay(hour: 10, minute: 30);
  String isDineIn = "0";

  @override
  Widget build(BuildContext context) {
    final hours = setTime.hour.toString().padLeft(2, '0');
    final minutes = setTime.minute.toString().padLeft(2, '0');
    cartController.updateId(id: widget.id);
    orderController.updateId(
      id: widget.id,
    );
    //get vendor Name
    String vendorName = "";
    //list of customization
    List pricesList = [];
    List quantityList = [];
    List itemList = [];

    //total price;

    List totalPriceList = [];
    double total = 0.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          elevation: 0,
          backgroundColor: buttonColor,
        ),
        body: Obx(
          () {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.cart.length,
                      itemBuilder: (context, index) {
                        final data = cartController.cart[index];
                        final totalPrice = data.foodPrice * data.quantity;

                        itemList.add(data.customization);
                        quantityList.add(data.quantity);
                        pricesList.add(data.foodPrice);
                        totalPriceList.add(totalPrice);
                        vendorName = data.vendorname;
                        return SlideMenu(
                          menuItems: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: ListTile(
                              leading: Image.network(
                                data.foodPic,
                              ),
                              title: Text(data.customization),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "RM ${data.foodPrice.toStringAsFixed(2)}"),
                                  Text("Quantity: ${data.quantity}"),
                                ],
                              ),
                              trailing: Text(
                                "RM ${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Take away or dine in?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isDineIn = "0";
                                });
                                print(isDineIn);
                              },
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                    color: isDineIn == "0"
                                        ? buttonColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                                print(isDineIn);
                              },
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                    color: isDineIn == "1"
                                        ? buttonColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Set time to have your meal",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
                                  borderRadius: BorderRadius.circular(10),
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
                                  borderRadius: BorderRadius.circular(10),
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
                          onPressed: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: setTime);
                            if (newTime == null) {
                              return;
                            }
                            setState(() {
                              setTime = newTime;
                            });
                          },
                          child: const Text("Set time"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: ElevatedButton(
                        onPressed: () {
                          orderController.postOrder(
                            quantities: quantityList,
                            totalPrice: totalPriceList,
                            vendorName: vendorName,
                            time: setTime,
                            items: itemList,
                            prices: pricesList,
                          );
                        },
                        child: const Text("Checkout"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
