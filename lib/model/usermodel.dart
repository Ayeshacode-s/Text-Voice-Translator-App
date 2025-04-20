

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phone;
  final String? address;


  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.address,
    this.phone
  });

  toJson(){
    return {

      "FullName":fullName,
      "Email":email,
      "Phone":phone,
      "Password":password,
      "Address":address,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName:data["FullName"],
      email:data["Email"],
      phone:data["Phone"],
      password:data["Password"],
      address:data["Address"],
    );
  }
}