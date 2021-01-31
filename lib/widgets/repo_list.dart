import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/repo.dart';
import '../providers/repo_provider.dart';
import '../widgets/repo_tile.dart';

class RepoList extends StatefulWidget {
  final int flag;
  final int flag2;
  // RepoList(this.flag);
  RepoList(this.flag, this.flag2);

  @override
  _RepoListState createState() => _RepoListState(flag, flag2);
}

class _RepoListState extends State<RepoList> {
  var _isInit = true;
  final int flag;
  final int flag2;
  _RepoListState(this.flag, this.flag2);

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
    print("chutiya flag ${flag}");
    // var repoList1;
    // if (flag == 0)
    //    repoList1 = repo.notMeRepo;
    // else if (flag == 1)
    // {
    //    repoList1 = repo.meRepo;

    // }
    final repoList = flag == 1
        ? (flag2 == 1 ? repo.showforkRepo : repo.meRepo)
        : repo.notMeRepo;

    print(repoList);
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: repoList.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: repoList[index],
          //child: Container(child: Text(repoList[index].description)),
          child: RepoTile(),
        ),
      ),
    );
  }
}
