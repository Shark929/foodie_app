import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/item_controller.dart';
import 'package:foodie_app/screens/users/screens/add_to_cart_screen.dart';
import 'package:get/get.dart';

class CuisineScreen extends StatelessWidget {
  final String cuisine;
  const CuisineScreen({super.key, required this.cuisine});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Text(cuisine),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            GetX<ItemController>(
                init: Get.put(ItemController()),
                builder: (ItemController itemController) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemController.items.length,
                      itemBuilder: (context, index) {
                        final itemModel0 = itemController.items[index];
                        if (itemModel0.itemCuisineType == cuisine) {
                          return ListTile(
                            onTap: () {
                              Get.to(() => AddToCartScreen(
                                    item: itemModel0,
                                  ));
                            },
                            leading: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(itemModel0.itemPicture),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title: Text(itemModel0.itemName),
                            subtitle: Text(itemModel0.itemDescription),
                            trailing: Text(
                              "RM ${double.parse(itemModel0.itemPrice).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      });
                })
          ]),
        ),
      ),
    ));
  }
}
