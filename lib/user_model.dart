import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String  mail;
  final String  name;
  final String  mobileNo;

  final DateTime addedTime;
  String? docID;

  UserModel({
    required this.name,
    required this.mail,
    required this.mobileNo,

    required this.addedTime,
    this.docID,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return UserModel(
      mail:data!['mail'] ,
      name: data['name'],
      mobileNo:data['mobileNo'] ,
      addedTime: DateTime.parse(data['addedTime'].toDate().toString()),
      docID: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'mail': mail,
      'name': name,
      'mobileNo': mobileNo,
      'addedTime': addedTime,
    };
    return data;
  }
}