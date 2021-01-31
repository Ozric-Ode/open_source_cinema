import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/repo.dart';
import '../providers/repo_provider.dart';
import '../widgets/repo_tile.dart';

class RepoList extends StatefulWidget {
  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      Provider.of<RepoProvider>(context).fetchAndSetRepos();
      Provider.of<RepoProvider>(context, listen: false).homerepo('All');
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepoProvider>(context);

    final repoList = repo.notMeRepo;
    print(repoList);
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: repoList.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: repoList[index],
            //child: Container(child: Text(repoList[index].description)),
            child: RepoTile(),),
      ),
    );
  }
}
