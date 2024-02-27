
import 'package:chat_app/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  RxList<UserModel> userList = <UserModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String chatRoomId(String user1,String user2){
    if(user1[0].toLowerCase().codeUnits[0] > user2[0].toString().codeUnits[0]){
      return "$user1$user2";
    }else{
      return "$user2$user1";
    }
  }


  Stream<QuerySnapshot> listenUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy("addedTime", descending: true)
        .snapshots();
  }

}