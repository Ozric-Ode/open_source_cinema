import 'package:flutter/material.dart';
import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'dart:async';
import '../providers/auth.dart';


class OwnRepo extends StatelessWidget {
  static final  String routename="/abc";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:RepoList(1,0),
    );
  }
}