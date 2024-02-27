import 'dart:developer';

import 'package:chat_app/Controllers/chat_controller.dart';
import 'package:chat_app/View/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  String userName;
  String chatRoomId;
   ChatScreen({super.key,required this.userName,required this.chatRoomId});

   ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        title:  Text(userName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.fireStore.collection('chatroom').doc(chatRoomId).collection('chats').orderBy("time", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const  Center(
                      child: CircularProgressIndicator()
                  );
                }else if (snapshot.data != null) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                          alignment:snapshot.data!.docs[index]['sendBy'] == controller.auth.currentUser!.displayName! ? Alignment.centerRight:Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal:14),
                            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.withOpacity(0.8)
                              ),
                              child: Text(snapshot.data!.docs[index]['message'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                              )));
                    },
                  );
                }else {
                  return const  Center(
                      child: Text('Empty')
                  );
                }

              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    child: TextField(
                      controller: controller.messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (controller.messageController.text.isNotEmpty) {
                      controller.sendMessage(chatRoomId:chatRoomId);
                      controller.messageController.clear();
                    }else{
                      log('Pleas enter message');
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

