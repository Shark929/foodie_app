import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';

class MenuProfileScreen extends StatelessWidget {
  final String uid;
  const MenuProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
      ),
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
