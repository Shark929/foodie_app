import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/auth_controller.dart';
import 'package:foodie_app/screens/home.dart';
import 'package:foodie_app/screens/users/auth/login_screen.dart';
import 'package:foodie_app/screens/users/auth/register_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie App',
      theme: ThemeData(
        primaryColor: buttonColor,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
