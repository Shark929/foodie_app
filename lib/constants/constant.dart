import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/controllers/auth_controller.dart';
import 'package:foodie_app/screens/users/screens/cart_screen3.dart';
import 'package:foodie_app/screens/users/screens/home.dart';
import 'package:foodie_app/screens/users/screens/order_screen2.dart';
import 'package:foodie_app/screens/users/screens/user_profile_screen.dart';
import 'package:foodie_app/screens/users/screens/wallet_screen.dart';

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
  // OrderScreen(
  //   id: authController.user.uid,
  // ),
  const OrderScreen2(),
  UserWalletScreen(
    id: authController.user.uid,
  ),
  const CartScreen3(),

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

//Customization
const custom = [
  {
    "id": "Burger",
    "custom": "Chicken Burger",
  },
  {
    "id": "Burger",
    "custom": "Beef Burger",
  },
  {
    "id": "Burger",
    "custom": "Fish Burger",
  },
];

const location = [
  "Bukit Bintang",
  "Petaling Jaya",
  "KLCC",
];

const mall = [
  "Pavilion",
  "Petaling Jaya Mall",
  "Suria KLCC",
];

const LocationList = [
  {
    "location": "Petaling Jaya",
    "mall": "Paradigm Mall",
  },
  {
    "location": "Petaling Jaya",
    "mall": "Jaya Shopping Center",
  },
  {
    "location": "Petaling Jaya",
    "mall": "Atria Shopping Gallery",
  },
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

//order
List orders = [
  {
    "item_name": "Chicken Burger",
    "item_description": "Chicken Burger",
    "quantity": "2",
    "item_price": "23.90",
    "order_number": "997",
    "time": "29/02/2023 14:13 PM",
    "total_price": "47.80",
  },
  {
    "item_name": "Chicken Burger",
    "item_description": "Chicken Burger",
    "quantity": "2",
    "item_price": "23.90",
    "order_number": "998",
    "time": "29/02/2023 14:13 PM",
    "total_price": "47.80",
  }
];

List cartList = [
  {
    "item_name": "Chicken Burger",
    "item_description": "Chicken Burger",
    "quantity": "2",
    "item_price": "23.90",
    "total_price": "47.80",
  },
  {
    "item_name": "Fish Burger",
    "item_description": "Fish Burger",
    "quantity": "1",
    "item_price": "25.90",
    "total_price": "25.90",
  },
];
