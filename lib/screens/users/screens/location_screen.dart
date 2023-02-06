import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/location_controller.dart';
import 'package:foodie_app/controllers/mall_controller.dart';
import 'package:foodie_app/screens/users/screens/mall_screen.dart';
import 'package:get/get.dart';

class LocationScreen extends StatelessWidget {
  final String location;
  const LocationScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: Text(
            location,
          ),
          elevation: 0,
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
                  "Mall in this location: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetX<MallController>(
                    init: Get.put(MallController()),
                    builder: (MallController mcController) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: mcController.mall.length,
                          itemBuilder: (context, index) {
                            final lcModel0 = mcController.mall[index];
                            if (lcModel0.location == location) {
                              return ListTile(
                                onTap: () {},
                                title: Text(lcModel0.mall),
                              );
                            }
                            return const SizedBox();
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
