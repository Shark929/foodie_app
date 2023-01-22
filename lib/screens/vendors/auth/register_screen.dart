import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/widgets/text_input.dart';

class VendorRegisterScreen extends StatelessWidget {
  VendorRegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Vendor Register",
                style: titleFont,
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: IconButton(
                      onPressed: () => authController.pickImage(),
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
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
                onTap: () => authController.registerUser(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  image: authController.profilePhoto,
                ),
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
                      print("Navigating user");
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
