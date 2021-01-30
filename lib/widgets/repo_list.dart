import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/repo.dart';
import '../providers/repo_provider.dart';
import '../widgets/repo_tile.dart';

class RepoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repoList = Provider.of<RepoProvider>(context).repo;
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: repoList.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: repoList[index],
        child: RepoTile(),
      ),
    );
  }
}
