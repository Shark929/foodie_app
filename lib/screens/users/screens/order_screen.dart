import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/order_controller.dart';
import 'package:foodie_app/controllers/update_code_controller.dart';
import 'package:foodie_app/screens/users/screens/empty_order_page.dart';
import 'package:foodie_app/services/local_push_notification.dart';
import 'package:foodie_app/widgets/order_widget.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  final String id;
  const OrderScreen({super.key, required this.id});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    // listenToNotification();
    super.initState();
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
    }
  }

  void orderAcceptedNoti() async {
    await service.showNotificationWithPayload(
        id: 0,
        title: 'Foodie',
        body: 'Vendor has accept your order',
        payload: 'payload navigation');
  }

  void preparingNoti() async {
    await service.showNotificationWithPayload(
        id: 0,
        title: 'Foodie',
        body: 'Vendor is preparing your foods',
        payload: 'payload navigation');
  }

  void orderCompletedNoti() async {
    await service.showNotificationWithPayload(
        id: 0,
        title: 'Foodie',
        body: 'Your order is completed',
        payload: 'payload navigation');
  }

  @override
  Widget build(BuildContext context) {
    final updateController = Get.put(UpdateController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
              onTap: () async {
                await service.showNotificationWithPayload(
                    id: 0,
                    title: 'Foodie',
                    body: 'Vendor has accept your order',
                    payload: 'payload navigation');
              },
              child: const Text("Order")),
          elevation: 0,
          backgroundColor: buttonColor,
        ),
        body:

            //if no order then show "No order page"

            //else show order page

            GetX<OrderController>(
                init: Get.put(OrderController()),
                builder: (OrderController orderController) {
                  for (int i = 0; i < orderController.cartList.length; i++) {
                    if (orderController.cartList[i].code == "2") {
                      orderAcceptedNoti();
                    }
                    if (orderController.cartList[i].code == "3") {
                      preparingNoti();
                    }
                    if (orderController.cartList[i].code == "4") {
                      orderCompletedNoti();
                    }

                    if (orderController.cartList[i].uid ==
                            authController.user.uid &&
                        orderController.cartList[i].code != "5") {
                      return Column(
                        children: [
                          GetX<UpdateController>(
                            builder: (_) => OrderWidget(
                                code: updateController.count.toString()),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text(
                              "My order",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: orderController.cartList.length,
                                itemBuilder: (context, index) {
                                  final orderModel0 =
                                      orderController.cartList[index];
                                  var totalPrice = orderModel0.quantity *
                                      orderModel0.foodPrice;
                                  updateController.updateNum(
                                      RxInt(int.parse(orderModel0.code)));
                                  if (orderModel0.uid ==
                                      authController.user.uid) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    orderModel0.foodPic),
                                              ),
                                            ),
                                          ),
                                          title: Text(orderModel0.foodName),
                                          subtitle: Text(
                                              "Quantity: X ${orderModel0.quantity}"),
                                          trailing: Text(
                                            "RM ${totalPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  return const SizedBox();
                                }),
                          ),
                        ],
                      );
                    }
                  }
                  return const EmptyOrderPage();
                }),
      ),
    );
  }
}
