import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/order_controller.dart';
import 'package:foodie_app/controllers/update_code_controller.dart';
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
          body: Column(
            children: [
              GetX<UpdateController>(
                builder: (_) =>
                    OrderWidget(code: updateController.count.toString()),
              ),
              GetX<OrderController>(
                  init: Get.put(OrderController()),
                  builder: (OrderController orderController) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderController.cartList.length,
                        itemBuilder: (context, index) {
                          final orderModel0 = orderController.cartList[index];
                          var totalPrice =
                              orderModel0.quantity * orderModel0.foodPrice;
                          updateController
                              .updateNum(RxInt(int.parse(orderModel0.code)));
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(orderModel0.foodPic),
                                    ),
                                  ),
                                ),
                                title: Text(orderModel0.foodName),
                                subtitle:
                                    Text("Quantity: X ${orderModel0.quantity}"),
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
                        });
                  }),
            ],
          )),
    );
  }
}
