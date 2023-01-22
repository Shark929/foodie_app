import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/screens/vendors/screens/confirm_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({super.key});

  pickImage(ImageSource src, BuildContext context) async {
    final image = await ImagePicker().pickImage(source: src);
    if (image != null) {
      print("Image picked");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            imageFile: File(image.path),
            imagePath: image.path,
          ),
        ),
      );
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickImage(ImageSource.gallery, context),
                  child: Row(children: [
                    Icon(Icons.image),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Gallery"),
                    ),
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(children: [
                    Icon(Icons.cancel),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancel"),
                    ),
                  ]),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(),
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: InkWell(
            onTap: () => showOptionDialog(context),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Add Menu",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
