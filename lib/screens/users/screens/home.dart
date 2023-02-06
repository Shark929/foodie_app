import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/item_controller.dart';
import 'package:foodie_app/screens/users/screens/chatroom_screen.dart';
import 'package:foodie_app/widgets/home_screen_widget.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchInputController = TextEditingController();

  String searchResult = "";

  //final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Foodie"),
          backgroundColor: buttonColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const ChatRoom());
                },
                icon: const Icon(Icons.chat))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 2,
                      color: Colors.black26,
                    ),
                  ),
                  child: TextField(
                    controller: searchInputController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: "Search ...",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // searchController.searchMenu(value);
                      setState(() {
                        searchResult = value;
                      });
                    },
                  ),
                ),
                searchResult == ""
                    ? HomeScreenWidget()
                    : GetX<ItemController>(
                        init: ItemController(),
                        builder: (ItemController iController) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: iController.items.length,
                              itemBuilder: (context, index) {
                                final iModel0 = iController.items[index];
                                if (searchResult.contains(
                                        iModel0.itemCategory.toLowerCase()) ||
                                    searchResult.contains(iModel0
                                        .itemCuisineType
                                        .toLowerCase()) ||
                                    searchResult.contains(
                                        iModel0.itemName.toLowerCase())) {
                                  return ListTile(
                                    title: Text(iModel0.itemName),
                                  );
                                } else {
                                  return const SizedBox();
                                }
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
