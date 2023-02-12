import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/get_order_number_controller.dart';
import 'package:foodie_app/controllers/order_controller2.dart';
import 'package:foodie_app/controllers/order_item_controller.dart';
import 'package:foodie_app/widgets/order_widget.dart';
import 'package:get/get.dart';

class OrderScreen2 extends StatefulWidget {
  const OrderScreen2({super.key});

  @override
  State<OrderScreen2> createState() => _OrderScreen2State();
}

class _OrderScreen2State extends State<OrderScreen2> {
  final getNumberController = Get.put(GetOrderNumberController());
  @override
  Widget build(BuildContext context) {
    print(getNumberController.number);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My order"),
          elevation: 0,
          backgroundColor: buttonColor,
        ),
        body: GetX<OrderController2>(
            init: Get.put(OrderController2()),
            builder: (OrderController2 oc2) {
              for (int i = 0; i < oc2.order.length; i++) {
                if (oc2.order[i].customerId == authController.user.uid) {
                  var code = oc2.order[i].code;
                  var orderNumber = oc2.order[i].orderNumber;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          OrderWidget(code: code),
                          GetX<OrderItemController2>(
                              init: Get.put(OrderItemController2(
                                  orderNumber: orderNumber)),
                              builder: (OrderItemController2 oc2Controller) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: oc2Controller.order.length,
                                    itemBuilder: (context, index) {
                                      final oc = oc2Controller.order[index];
                                      return ListTile(
                                        leading: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    oc.itemPicture),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        title: Text(oc.itemName),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("X${oc.quantity}"),
                                            Text("RM ${oc.itemPrice}")
                                          ],
                                        ),
                                        trailing: Text(
                                          "RM ${oc.totalPrice}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ],
                      ),
                    ),
                  );
                }
              }
              return const Center(
                child: Text("Empty order"),
              );
            }),
      ),
    );
  }
}
