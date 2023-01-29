import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/menu_controller.dart';
import 'package:foodie_app/screens/users/screens/add_to_cart_screen.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  CategoryScreen({super.key, required this.category});

  final MenuController1 menuController = Get.put(MenuController1());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          return ListView.builder(
              itemCount: menuController.menuList.length,
              itemBuilder: (context, index) {
                final data = menuController.menuList[index];
                if (category == data.category) {
                  return InkWell(
                    onTap: () {
                      Get.to(AddToCartScreen(
                        menu: data,
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(data.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.foodname,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.foodDescription,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RM ${data.foodPrice}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              });
        }),
      ),
    );
  }
}
