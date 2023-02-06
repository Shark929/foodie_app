import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/models/chat_model.dart';

class ChatFirestoreDb {
  //create
  static addChat(ChatModel chatModel) async {
    await firebaseFirestore.collection('chatroom').add({
      'chatRoomId': chatModel.chatRoomId,
      'conversation': chatModel.conversation,
      'date': chatModel.date,
      'userId': chatModel.userId,
      'vendorId': chatModel.vendorId,
    });
  }

  //read
  static Stream<List<ChatModel>> chatStream() {
    return firebaseFirestore
        .collection('chatroom')
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ChatModel> chats = [];
      for (var chat in querySnapshot.docs) {
        final chatModel = ChatModel.fromDocumentSnapshot(chat);
        chats.add(chatModel);
      }

      return chats;
    });
  }

  //update

  //delete
}
