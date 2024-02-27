import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

   RxString uid= "".obs;
   double scrollOffset = double.infinity;

   FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();
   final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendMessage({String? chatRoomId}) async {

    Map<String ,dynamic> message ={
      "sendBy": auth.currentUser!.displayName,
      "message":messageController.text.toString(),
      "time":FieldValue.serverTimestamp()
    };

     await fireStore
         .collection('chatroom')
         .doc(chatRoomId)
         .collection('chats')
         .add(message);


    update();

  }


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}