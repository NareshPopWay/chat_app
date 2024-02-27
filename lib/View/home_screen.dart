

import 'dart:developer';

import 'package:chat_app/Controllers/chat_controller.dart';
import 'package:chat_app/Controllers/home_controller.dart';
import 'package:chat_app/View/chat_screen.dart';
import 'package:chat_app/View/login_screen.dart';
import 'package:chat_app/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        title: const Text('Chat App'),
        actions: [
          IconButton(
            onPressed: () {
              controller.auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()),result: (Route<dynamic> route) => false,);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(top: Get.height*0.01,left: Get.width*0.04,right: Get.width*0.04,bottom: Get.width*0.55),
        child: StreamBuilder<QuerySnapshot>(
            stream: controller.listenUsers(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return  Center(
                    heightFactor: Get.height * 0.025,
                    child: Text('Something went wrong',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * 0.042,
                      ),
                    ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  heightFactor: Get.height * 0.022,
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
              controller.userList.clear();
              snapshot.data!.docs.forEach((doc)  {
                var users = UserModel.fromFirestore(doc);
                controller.userList.add(users);
                if(controller.userList.where((item) => item.name == controller.auth.currentUser!.displayName).isEmpty){
                  controller.userList.map((element){
                    controller.userList.remove(UserModel(name: element.name, mail: element.mail, mobileNo: element.mobileNo, addedTime: element.addedTime));
                  });
                }
              });

              // snapshot.data!.docChanges.forEach((change) {
              //   if (change.type == DocumentChangeType.modified ||
              //       change.type == DocumentChangeType.removed) {
              //     _childStateUpdateController.updateState?.call();
              //   }
              // });

              return  controller.userList.isEmpty?
              Center(
                heightFactor: Get.height * 0.03,
                child: Text('Users not Found',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.width * 0.05,
                  ),
                ),
              )
                  :  ListView.builder(
                  shrinkWrap: true,
                   // padding: EdgeInsets.only(top: Get.height*0.02,left: Get.width*0.02,right: Get.width*0.02,bottom: Get.width*0.04 ),
                  physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.blueAccent.withOpacity(.10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: const Icon(Icons.account_circle,size:40,color: Colors.grey,),
                        ),
                        title: Text(controller.userList[index].name,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle:  Text(controller.userList[index].mail),
                        onTap: (){
                          String roomId = controller.chatRoomId(controller.auth.currentUser!.displayName!,controller.userList[index].name);
                          log(roomId);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(userName: controller.userList[index].name,chatRoomId: roomId,)));
                        },
                      ),
                    );
                  });
            }
        ),
      ),

    );
  }
}

