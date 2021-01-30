import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:provider/provider.dart';

class RepoOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:AppDrawer(),
      appBar: AppBar(
        title: Text('Open Source Cinema'),
      ),
      body: RepoList(),
    );
  }
}
