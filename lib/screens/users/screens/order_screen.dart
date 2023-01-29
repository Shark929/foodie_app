import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/order_controller.dart';
import 'package:foodie_app/services/local_push_notification.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  final String id;
  OrderScreen({super.key, required this.id});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderController orderController = Get.put(OrderController());

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

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }

  @override
  Widget build(BuildContext context) {
    orderController.updateId(id: widget.id);
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
          body: orders.isEmpty
              ? const Center(
                  child: Text("No orders yet"),
                )
              : Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/orders.png",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.amber,
                                      )),
                                ),
                                const Spacer(),
                                Text("Order accepted"),
                              ],
                            ),
                            Container(
                              width: 4,
                              height: 25,
                              margin: const EdgeInsets.only(
                                left: 13.5,
                              ),
                              color: Colors.amber,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.black,
                                      )),
                                ),
                                const Spacer(),
                                Text("Chef is preparing"),
                              ],
                            ),
                            Container(
                              width: 4,
                              height: 25,
                              margin: const EdgeInsets.only(
                                left: 13.5,
                              ),
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      )),
                                ),
                                const Spacer(),
                                Text("Order completed"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: const Text(
                            "Order details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(orders[index]['item_name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("X ${orders[index]['quantity']}")
                                ],
                              ),
                              trailing: Text(
                                "RM ${orders[index]['item_price']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )),
    );
  }
}
