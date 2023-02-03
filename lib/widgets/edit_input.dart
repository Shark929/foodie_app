import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';

class EditInputField extends StatefulWidget {
  final String label, hintText;
  final TextInputType keyboardType;
  final Function() doneFunction;
  final TextEditingController controller;
  EditInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.doneFunction,
    required this.controller,
    this.keyboardType = TextInputType.name,
  });

  @override
  State<EditInputField> createState() => _EditInputFieldState();
}

class _EditInputFieldState extends State<EditInputField> {
  String inputValue = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.label),
              const Spacer(),
              InkWell(
                  onTap: widget.doneFunction,
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: inputValue == "" ? Colors.grey : buttonColor,
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
                onChanged: (value) {
                  setState(() {
                    inputValue = value;
                  });
                },
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                )),
          )
        ],
      ),
    );
  }
}
