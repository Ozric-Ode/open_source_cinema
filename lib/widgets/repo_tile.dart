import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repo.dart';
import '../providers/repo_provider.dart';

class RepoTile extends StatelessWidget {
  @override
  final title='';
  // final 

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text('Two-line ListTile'),
        subtitle: Text('Here is a second line'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
