import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/user_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/widgets/edit_input.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: buttonColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              EditInputField(
                keyboardType: TextInputType.text,
                controller: usernamecontroller,
                label: "Username",
                hintText: "Username",
                doneFunction: () {
                  UserFirestoreDb.updateUsername(
                      usernamecontroller.text, authController.user.uid);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              EditInputField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                label: "Phone",
                hintText: "0123456789",
                doneFunction: () {
                  UserFirestoreDb.updatePhone(
                      phoneController.text, authController.user.uid);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
