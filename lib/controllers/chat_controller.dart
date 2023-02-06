import 'package:foodie_app/Firestore/chat_firestore_db.dart';
import 'package:foodie_app/models/chat_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);

  List<ChatModel> get chat => chatList.value;

  @override
  void onReady() {
    chatList.bindStream(ChatFirestoreDb.chatStream());
  }
}
