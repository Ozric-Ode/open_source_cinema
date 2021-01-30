import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repo.dart';
import '../providers/repo_provider.dart';

class RepoTile extends StatelessWidget {
  final String title;
  final String desc;
  RepoTile(
    this.title,
    this.desc,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(title),
        subtitle: Text(desc),
        trailing: Icon(
          Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
