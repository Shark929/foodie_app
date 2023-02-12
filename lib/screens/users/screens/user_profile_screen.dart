import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/user_controller.dart';
import 'package:foodie_app/screens/users/screens/edit_profile_screen.dart';
import 'package:foodie_app/screens/users/screens/order_history.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  @override
  State<UserProfileScreen> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: const Text("Profile"),
        ),
        body: GetX<UserController>(
            init: Get.put(UserController()),
            builder: (UserController vendor2Controller) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: vendor2Controller.users.length,
                  itemBuilder: (context, index) {
                    final vendorModel0 = vendor2Controller.users[index];
                    if (vendorModel0.userId == authController.user.uid) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: vendorModel0.profilePicture == ""
                                    ? Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 254, 204, 22),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          vendorModel0.username[0],
                                          style: const TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                vendorModel0.profilePicture),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => const EditProfileScreen());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Edit profile"),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Username: ${vendorModel0.username}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email: ${vendorModel0.email}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Phone: ${vendorModel0.phoneNum}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const OrderHistoryScreen());
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Order history",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  authController.signOut();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: buttonColor,
                                  ),
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
