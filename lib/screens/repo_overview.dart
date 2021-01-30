import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class RepoOverview extends StatelessWidget {
  Future<void> fun() async {
    final dbRef = FirebaseDatabase.instance.reference().child("users");

    await dbRef
        .orderByChild("userid")
        .equalTo("TG3flo3AUseRONcN7ls3Y6RcoKP2")
        .once()
        .then((DataSnapshot dataSnapshot) {
      var newKey = dataSnapshot.value;
      var _list = newKey.values.toList();
      print(_list);
      var _lis = _list[0].values.toList();
      print(_lis);
      String userAuthid = _lis[1];
      print(userAuthid);
      newKey.forEach((k, v) => print('${k}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    fun();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Open Source Cinema'),
      ),
      body: RepoList(),
    );
  }
}
