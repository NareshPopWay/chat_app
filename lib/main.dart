import 'package:chat_app/View/chat_screen.dart';
import 'package:chat_app/View/home_screen.dart';
import 'package:chat_app/View/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions options;

    options = const FirebaseOptions(
        apiKey: "AIzaSyBksqqLu9CJmH1UpY7BcQFOMYIT7bHmSc0",
        appId: "1:703735000921:android:357a7ae8c6ef9ddee0a648",
        messagingSenderId: "703735000921",
        projectId: "chatapp-36d64");

  await Firebase.initializeApp(options: options);

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:_auth.currentUser == null? LoginScreen() : HomeScreen(),
    );
  }
}

