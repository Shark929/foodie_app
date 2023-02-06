import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/location_controller.dart';
import 'package:foodie_app/controllers/mall_controller.dart';
import 'package:foodie_app/screens/users/screens/category_screen.dart';
import 'package:foodie_app/screens/users/screens/chatroom_screen.dart';
import 'package:foodie_app/screens/users/screens/cuisine_screen.dart';
import 'package:foodie_app/screens/users/screens/location_screen.dart';
import 'package:foodie_app/screens/users/screens/mall_screen.dart';
import 'package:foodie_app/screens/users/screens/promotions_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});
  TextEditingController searchInputController = TextEditingController();
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
                  Get.to(() => ChatRoom());
                },
                icon: Icon(Icons.chat))
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
                      //searchController.searchMenu(value);
                    },
                  ),
                ),
                // searchController.searchMenus.isEmpty ||
                //         searchInputController.text == ""
                //     ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Promotions
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Promotions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: promotion.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => PromotionScreen(
                                      percentage: promotion[index]['percentage']
                                          .toString(),
                                      label:
                                          promotion[index]['label'].toString(),
                                      code: promotion[index]['code'].toString(),
                                    ));
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${promotion[index]['percentage']}%",
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(promotion[index]['label'].toString()),
                                    Text("Code: ${promotion[index]['code']}"),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Cuisines",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cuisines.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CuisineScreen(
                                          cuisine: cuisines[index]),
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    cuisines[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),

                    //Category
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          category: category[index]),
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    category[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),

                    //locations
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Locations",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                        height: 50,
                        child: GetX<LocationController>(
                            init: Get.put(LocationController()),
                            builder: (LocationController lcController) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lcController.location.length,
                                  itemBuilder: (context, index) {
                                    final lcModel0 =
                                        lcController.location[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => LocationScreen(
                                            location: lcModel0.locationName));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(lcModel0.locationName),
                                      ),
                                    );
                                  });
                            })),
                    //malls
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Malls",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 50,
                        child: GetX<MallController>(
                            init: Get.put(MallController()),
                            builder: (MallController mcController) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mcController.mall.length,
                                  itemBuilder: (context, index) {
                                    final mcModel0 = mcController.mall[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            MallScreen(mall: mcModel0.mall));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(mcModel0.mall),
                                      ),
                                    );
                                  });
                            })),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
