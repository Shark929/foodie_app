import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/vendor_controller.dart';
import 'package:foodie_app/screens/users/screens/vendor_menu_screen.dart';
import 'package:get/get.dart';

class MallScreen extends StatelessWidget {
  final String mall;
  const MallScreen({super.key, required this.mall});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(mall),
        backgroundColor: buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Restaurants in this mall: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetX<Vendor2Controller>(
                  init: Get.put(Vendor2Controller()),
                  builder: (Vendor2Controller vdController) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: vdController.vendor.length,
                        itemBuilder: (context, index) {
                          final vModel0 = vdController.vendor[index];
                          if (vModel0.vendorMall == mall) {
                            return ListTile(
                              onTap: () {
                                Get.to(
                                  () =>
                                      VendorScreen(vendorId: vModel0.vendorId!),
                                );
                              },
                              leading: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(vModel0.vendorImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(vModel0.vendorRestaurantName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${vModel0.openHour}a.m. - ${vModel0.closeHour}p.m."),
                                  // Text(vModel0.vendorPhone),
                                  // Text(vModel0.vendorEmail),
                                ],
                              ),
                              trailing: Text(
                                  vModel0.isOpen == false ? "Closed" : "Open"),
                            );
                          }
                          return const SizedBox();
                        });
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
