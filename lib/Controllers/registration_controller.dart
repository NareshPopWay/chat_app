import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/View/home_screen.dart';
import 'package:chat_app/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistrationController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool secureText = true.obs;
  RxBool securePText = true.obs;
  RxBool isRegister = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void onInit() async {
    super.onInit();
  }


  Future<bool> addUser({required UserModel user}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc()
          .set(user.toMap());
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future registration(context) async{

    try {
      isRegister.value = true;
      User? user =   (await firebaseAuth
          .createUserWithEmailAndPassword(
          email: email.value.text,
          password: password.value.text)).user;

      if(user != null){
        
        user.updateProfile(displayName:userName.text);
        
        addUser(user: UserModel(
            name: userName.text,
            mail: email.text,
            mobileNo: phoneNumber.text,
            addedTime: DateTime.now()))
            .then((value) async{
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior
                .floating,
            backgroundColor: Colors
                .transparent,
            content: AwesomeSnackbarContent(
              title: 'Registration Successfully',
              message: 'Registration successfully done',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          isRegister.value = false;
          userName.clear();
          phoneNumber.clear();
          email.clear();
          password.clear();
          confirmPassword.clear();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()),result: (Route<dynamic> route) => false,);

        });
        return user;
      }else{
        isRegister.value = false;
        return user;
      }


      //     .onError((error, stackTrace) {
      //   final snackBar = SnackBar(
      //     /// need to set following properties for best effect of awesome_snackbar_content
      //     elevation: 0,
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     content: AwesomeSnackbarContent(
      //       title: 'Something went wrong',
      //       inMaterialBanner: true,
      //       message: error.toString().split(']')[1],
      //       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      //       contentType: ContentType.failure,
      //     ),
      //   );
      //   ScaffoldMessenger.of(context)
      //     ..hideCurrentSnackBar()
      //     ..showSnackBar(snackBar);
      //   log('${error.toString().split(']')[1]}');
      //   isRegister.value = false;
      // });

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch(e){
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Somethings went wrong!',
          message: e.toString(),
          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      isRegister.value = false;
      log(e.toString());

    }
  }
}
