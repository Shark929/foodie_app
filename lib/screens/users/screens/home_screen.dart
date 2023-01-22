import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 205, 205, 205),
          selectedItemColor: buttonColor,
          unselectedItemColor: Colors.black,
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.fastfood,
                  size: 30,
                ),
                label: "Order"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wallet,
                  size: 30,
                ),
                label: "Wallet"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: "Profile"),
          ]),
    );
  }
}
