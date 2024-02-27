import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool secureText = true.obs;
  RxBool isLogin = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void onInit() {
    super.onInit();
  }

  Future login(context) async{

    try {
      isLogin.value = true;


      await _auth
          .signInWithEmailAndPassword(
          email: email.value.text,
          password: password.value.text).then((value) {
        // if(fcmToken.value == fcmLocalToken.value){

          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Login Successfully',
              message: 'Login successfully done',
              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          isLogin.value = false;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()),result: (Route<dynamic> route) => false,);




      }).onError((error, stackTrace) {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Something went wrong',
            inMaterialBanner: true,
            message: error.toString().split(']')[1],
            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        log('${error.toString().split(']')[1]}');
        isLogin.value = false;
      });

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        isLogin.value = false;
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided.');
        isLogin.value = false;
      }
    }catch(e){

    }
  }

}