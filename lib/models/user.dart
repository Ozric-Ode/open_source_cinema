import "package:flutter/material.dart";
import "./repo.dart";
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users{
   String userId;
  String name;
  String email;

  Users({
    this.userId,
    this.name,
    this.email,
  });

}

class User with ChangeNotifier {
  String userId;
  String name;
  String email;

  User({
    this.userId,
    this.name,
    this.email,
  });

  Future<String> addUsers(String token) async {
    final url =
        'https://open-source-cinema-default-rtdb.firebaseio.com/users.json/?auth=$token'; //$userId.json
    print("success");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': name,
          'email': email,
          'userid': userId,
        }),
      );
      print(response.body);
      final responseData2 = json.decode(response.body);
      String _authUserId;
      _authUserId = responseData2['name'];
      return _authUserId;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<User> fetchUser(String authUserId) async {
    print("Authuserid ${authUserId}");
    final dbRef =
        FirebaseDatabase.instance.reference().child("users").child(authUserId);

    var newKey;
    await dbRef.once().then((DataSnapshot dataSnapshot) {
      newKey = dataSnapshot.value;

      print("Name = ${newKey['name']}");
    });
    print("Madarchod ${newKey}");
    
    User userobj=new User(userId:newKey['userid'] ,email:newKey['email'] ,name:newKey['name']);
     return userobj;
  }
}