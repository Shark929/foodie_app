import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/user_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/auth_controller.dart';
import 'package:foodie_app/models/user_model.dart';
import 'package:foodie_app/screens/users/auth/login_screen.dart';
import 'package:foodie_app/widgets/text_input.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/Logo.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Register",
                  style: titleFont,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Stack(
                //   children: [
                //     const CircleAvatar(
                //       radius: 50,
                //       backgroundImage: NetworkImage(
                //           "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                //     ),
                //     Positioned(
                //       bottom: -10,
                //       left: 60,
                //       child: IconButton(
                //         onPressed: () => authController.pickImage(),
                //         icon: const Icon(
                //           Icons.add_a_photo,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: usernameController,
                    label: "Username",
                    icon: Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: phoneController,
                    label: "Phone",
                    icon: Icons.call,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: passwordController,
                    label: "Password",
                    icon: Icons.lock,
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    // final userModel = UserModel(
                    //     username: usernameController.text,
                    //     email: emailController.text,
                    //     phoneNum: phoneController.text,
                    //     profilePicture: '');
                    // UserFirestoreDb.addUser(userModel);

                    authController.registerUser(
                        username: usernameController.text,
                        email: emailController.text,
                        phoneNum: phoneController.text,
                        password: passwordController.text);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
