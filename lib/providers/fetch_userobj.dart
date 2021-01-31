import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'dart:async';
import '../providers/auth.dart';

 class FetchUserObj {
  //User obj = new User(email: "", name: "", userId: "asdsadasdsad");
  // String initavatar = " ";
  // User userObj = new User();

  Future<void> getuser(BuildContext context,Users obj) async {
    final authUserId = Provider.of<Auth>(context, listen: true).authUserId;
    print("Authuserid-- ${authUserId}");

    obj = (await User.fetchUser(authUserId)) as Users;
    // initavatar = obj.name.substring(0, 1).toUpperCase();
    // print('madarchod bhosdika ${obj.name}  ${obj.email} ${obj.userId}');

   // return obj;
  }
  

// final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
//     var url =
//         'https://bhaadepay-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
  // static User fetchgetobj() {

  //   User obj = await getuser(context);
  //   return obj;
  // }
}
