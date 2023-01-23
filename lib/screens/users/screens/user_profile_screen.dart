import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/profile_controller.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;
  UserProfileScreen({super.key, required this.uid});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: buttonColor,
              elevation: 0,
              leading: const Icon(Icons.person_add_alt_1),
              actions: const [Icon(Icons.more_horiz)],
              title: Text(controller.user['username']),
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.user['profilePicture'],
                        height: 100,
                        width: 100,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Phone"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(controller.user['email']),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          authController.signOut();
                        },
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
