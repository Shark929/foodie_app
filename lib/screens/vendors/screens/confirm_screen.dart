import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/upload_menu_controller.dart';
import 'package:foodie_app/widgets/text_input.dart';
import 'package:get/get.dart';

class ConfirmScreen extends StatefulWidget {
  final File imageFile;
  final String imagePath;
  const ConfirmScreen({
    super.key,
    required this.imageFile,
    required this.imagePath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController foodnameController = TextEditingController();
  final TextEditingController fooddescriptionController =
      TextEditingController();
  final TextEditingController foodPriceController = TextEditingController();
  uploadMenuController saveMenuController = Get.put(uploadMenuController());
  String cuisineValue = cuisines[0];
  String categoryValue = category[0];
  String locationValue = location[0];
  String mallValue = mall[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.file(
                widget.imageFile,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: foodnameController,
                      label: "Food name",
                      icon: Icons.label,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: fooddescriptionController,
                      label: "Food decription",
                      icon: Icons.description,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      keyboardType: TextInputType.number,
                      controller: foodPriceController,
                      label: "Food price",
                      icon: Icons.price_change,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Food categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                        // Initial Value
                        value: cuisineValue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: cuisines.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            cuisineValue = newValue!;
                          });
                        },
                      ),
                      DropdownButton(
                        // Initial Value
                        value: categoryValue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: category.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => saveMenuController.uploadMenu(
                        foodname: foodnameController.text,
                        foodDescription: fooddescriptionController.text,
                        imagePath: widget.imagePath,
                        foodPrice: double.parse(foodPriceController.text)
                            .toStringAsFixed(2),
                        cuisine: cuisineValue,
                        category: categoryValue,
                        location: '',
                        mall: '',
                      ),
                      child: Text("Save Menu"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
