import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/screens/new_script.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ScriptsScreen extends StatefulWidget {
  static final String routeName = "/routeName";
  @override
  _ScriptsScreenState createState() => _ScriptsScreenState();
}

class _ScriptsScreenState extends State<ScriptsScreen> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final repoId =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    final loadedRepo = Provider.of<RepoProvider>(
      context,
      listen: false,
    ).findById(repoId);
    debugPrint(loadedRepo.title);
    debugPrint(loadedRepo.repoId);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Open Source Cinema"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.blue[200],
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemExtent: 100,
              itemCount: 20,
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return Container(
                    padding: EdgeInsets.only(right: 28),
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    height: 40,
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            // Navigator.of(context)
                            //     .pushNamed(NewScript.routeName);
                            Provider.of<RepoProvider>(
                              context,
                              listen: false,
                            ).forkRepo(loadedRepo);
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Yippee!!"),
                                content: Text(
                                    "Shelf Forked!!\nGo to My profiles->My shelf to add bits and pieces into your brand new shelf"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Okay"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Fork"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NewScript.routeName);
                          },
                          child: Text("Add Script"),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  color: Colors.white54,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                        child: ListTile(
                          leading: Text(
                            'Title',
                            style: TextStyle(fontSize: 30, color: Colors.grey),
                          ),
                          trailing: IconButton(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 30,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      debugPrint("pressed");
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
