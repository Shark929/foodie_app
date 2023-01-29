import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';

class MallScreen extends StatelessWidget {
  final String mall;
  const MallScreen({super.key, required this.mall});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(mall),
        backgroundColor: buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Restaurants in this mall: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
