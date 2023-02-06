import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/order_controller.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Order history"),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GetX<OrderController>(
                init: Get.put(OrderController()),
                builder: (OrderController oController) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: oController.cartList.length,
                      itemBuilder: (context, index) {
                        final oModel0 = oController.cartList[index];
                        if (oModel0.uid == authController.user.uid &&
                            oModel0.code == "5") {
                          double totalPrice =
                              double.parse(oModel0.quantity.toString()) *
                                  double.parse(oModel0.foodPrice.toString());
                          return ListTile(
                            title: Text(oModel0.foodName),
                            subtitle: Text("X ${oModel0.quantity}"),
                            trailing: Text(
                              "RM ${totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
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
    ));
  }
}
