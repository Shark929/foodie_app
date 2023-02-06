import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/chat_controller.dart';
import 'package:foodie_app/screens/users/screens/chat_screen.dart';
import 'package:get/get.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      body: GetX<ChatController>(
          init: Get.put(ChatController()),
          builder: (ChatController cController) {
            //empty list
            List user = [];
            String chatroom = "";
            for (int i = 0; i < cController.chat.length; i++) {
              chatroom = cController.chat[i].chatRoomId;
              final splitted = chatroom.split('&&');
              if (user.isEmpty || !user.contains(splitted[1])) {
                user.add(splitted[0]);
              }
            }

            //filter

            if (user.isEmpty) {
              return const Center(child: Text("No chat"));
            } else {
              return ListTile(
                  onTap: () {
                    Get.to(() => ChatScreen(
                        vendorId: user[0],
                        customerId: authController.user.uid,
                        chatRoomId: chatroom));
                  },
                  tileColor: Colors.amber,
                  title: const Text("New message"));
            }
          }),
    ));
  }
}
