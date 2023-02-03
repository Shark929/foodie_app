import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final String code;
  const OrderWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset('assets/orders.png'),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: code == '2'
                              ? Colors.amber
                              : code == '3'
                                  ? Colors.amber
                                  : code == '4'
                                      ? Colors.amber
                                      : Colors.black,
                        )),
                  ),
                  const Spacer(),
                  const Text("Order accepted"),
                ],
              ),
              Container(
                width: 4,
                height: 25,
                margin: const EdgeInsets.only(
                  left: 13.5,
                ),
                color: code == "2"
                    ? Colors.amber
                    : code == "3"
                        ? Colors.amber
                        : code == "4"
                            ? Colors.amber
                            : Colors.black,
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: code == "3"
                              ? Colors.amber
                              : code == "4"
                                  ? Colors.amber
                                  : Colors.black,
                        )),
                  ),
                  const Spacer(),
                  const Text("Chef is preparing"),
                ],
              ),
              Container(
                width: 4,
                height: 25,
                margin: const EdgeInsets.only(
                  left: 13.5,
                ),
                color: code == "3"
                    ? Colors.amber
                    : code == "4"
                        ? Colors.amber
                        : Colors.black,
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: code == "4" ? Colors.amber : Colors.black,
                          width: 3,
                        )),
                  ),
                  const Spacer(),
                  const Text("Order completed"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
