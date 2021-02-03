import 'package:flutter/material.dart';
import 'package:open_source_cinema/screens/scripts_screen.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../models/repo.dart';
import '../providers/repo_provider.dart';

class RequestPage extends StatefulWidget {
  // final String title;
  // final String desc;
  // RepoTile(
  //   this.title,
  //   this.desc,
  // );

  static final String routeName = '/requestPage';
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
    // final repo = Provider.of<Repo>(context);
    final repo = ModalRoute.of(context).settings.arguments as Repo;
    return Scaffold(
      appBar: AppBar(
        title: Text("SEE YOUR request"),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: (repo.reqScript == null)
            ? Container()
            : ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: repo.reqScript.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: repo.reqScript[index],
                  //child: Container(child: Text(repoList[index].description)),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ScriptsScreen.routeName,
                          arguments: repo.repoId,
                        );
                      },
                      leading: FlutterLogo(size: 56.0),
                      title: Text(repo.title),
                      subtitle: Text(repo.description),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
