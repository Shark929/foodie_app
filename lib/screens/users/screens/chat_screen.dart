import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/Firestore/chat_firestore_db.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/controllers/chat_controller.dart';
import 'package:foodie_app/models/chat_model.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final String vendorId, customerId, chatRoomId;
  ChatScreen(
      {super.key,
      required this.vendorId,
      required this.customerId,
      required this.chatRoomId});
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: buttonColor,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(
              16,
            ),
            margin: const EdgeInsets.only(bottom: 40),
            height: MediaQuery.of(context).size.height - 130,
            child: GetX<ChatController>(
                init: Get.put(ChatController()),
                builder: (ChatController cController) {
                  return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: cController.chat.length,
                      itemBuilder: (context, index) {
                        final cModel0 = cController.chat[index];
                        if (cModel0.chatRoomId != chatRoomId) {
                          return const SizedBox();
                        } else {
                          return Align(
                            alignment: cModel0.userId != ""
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: cModel0.userId == ""
                                    ? Colors.amber
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                cModel0.conversation,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      });
                }),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      width: MediaQuery.of(context).size.width - 45,
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                            hintText: "Type your message..."),
                      )),
                  IconButton(
                    onPressed: () {
                      final cModel = ChatModel(
                          chatRoomId: chatRoomId,
                          vendorId: '',
                          userId: customerId,
                          date: Timestamp.fromDate(DateTime.now()),
                          conversation: messageController.text);

                      ChatFirestoreDb.addChat(cModel);
                      messageController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: buttonColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
