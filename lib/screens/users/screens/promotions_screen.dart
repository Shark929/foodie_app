import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:flutter/services.dart';

class PromotionScreen extends StatelessWidget {
  final String percentage, label, code;
  const PromotionScreen(
      {super.key,
      required this.percentage,
      required this.label,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: const Text("Promotions"),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${percentage}%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Text("Copy code"),
                  IconButton(
                      onPressed: () {
                        // await Clipboard.setData(ClipboardData(text: code));
                        Clipboard.setData(ClipboardData(text: code)).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$code copied to clipboard")));
                        });
                      },
                      icon: Icon(Icons.copy)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
