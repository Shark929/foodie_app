import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/controllers/auth_controller.dart';
import 'package:foodie_app/screens/users/screens/home.dart';
import 'package:foodie_app/screens/users/screens/user_profile_screen.dart';
import 'package:foodie_app/screens/users/screens/wallet_screen.dart';
import 'package:foodie_app/screens/vendors/screens/add_menu_screen.dart';

//COlors
const backgroundColor = Colors.white;
const inputColor = Color(0xffC6C6C6);
const buttonColor = Color(0xffEB721A);

//Fonts
const titleFont = TextStyle(
  fontSize: 25,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

//Controller
var authController = AuthController.instance;

//Pages
List pages = [
  Home(),
  Text("order"),
  UserWalletScreen(
    id: authController.user.uid,
  ),
  Text("cart"),
  UserProfileScreen(
    uid: authController.user.uid,
  ),
];

//Cuisines
const cuisines = [
  "Western",
  "Chinese",
  "Malay",
  "Indian",
  "Korean",
  "Japanese",
  "Indonesian",
  "Hawaian",
];

//Category
const category = [
  "Burger",
  "Soup Noodle",
  "Spaggheti",
  "Fried Rice",
];

//Location
const location = [
  "Cyberjaya",
  "Dengkil",
  "Klang",
  "Kuala Selangor",
  "Petaling Jaya",
  "Banting",
  "Cheras",
];
//Mall
const mall = [
  "Pavilion",
  "Setia City Mall",
  "Sunway Pyramid",
  "Mitsui Outlet Park",
  "One Utama",
  "IKEA",
  "Subang Parade",
];

//Promotions
const promotion = [
  {
    "code": "DINNER",
    "percentage": 30,
    "label": "from 6pm onwards",
  },
  {
    "code": "PESTAPANDA",
    "percentage": 40,
    "label": "Pesta foodpanda",
  },
  {
    "code": "HUAT15",
    "percentage": 15,
    "label": "Huat ah!",
  },
  {
    "code": "COKE28",
    "percentage": 28,
    "label": "take home the taste of CNY",
  },
];
