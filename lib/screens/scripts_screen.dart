import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
// import 'package:open_source_cinema/screens/new_request.dart';
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
        title: Text("Bits and Pieces"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.blue[200],
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemExtent: 100,
              itemCount: (loadedRepo.script.length + 1),
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return Container(
                    padding: EdgeInsets.only(right: 28),
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    height: 40,
                    width: 60,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                                      "Shelf Forked!!\nGo to My profiles->My shelf to add bits and pieces to this forked shelf"),
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
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  NewScript.routeName,
                                  arguments: loadedRepo.repoId);

                              // Navigator.of(context)
                              //     .pushNamed(NewScript.routeName);
                            },
                            child: Text("Add Script"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          (loadedRepo.authorId == loadedRepo.parentRepoId)
                              ? Container()
                              : RaisedButton(
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(NewRequest.routeName);
                                  },
                                  child: Text(" send request"),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          (loadedRepo.authorId == loadedRepo.parentRepoId)
                              ? Container()
                              : RaisedButton(
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(NewRequest.routeName);
                                  },
                                  child: Text("request to me "),
                                )
                        ],
                      ),
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
                          title: Text(
                            loadedRepo.script[i - 1].title,
                            style: TextStyle(fontSize: 30, color: Colors.grey),
                          ),
                          subtitle: Text(loadedRepo.script[i - 1].content),
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
  
// import 'package:flutter/material.dart';
// import 'package:open_source_cinema/models/repo.dart';
// import 'package:open_source_cinema/models/scripts.dart';
// import 'package:open_source_cinema/providers/repo_provider.dart';
// import 'package:open_source_cinema/screens/new_script.dart';
// import 'package:open_source_cinema/widgets/drawer.dart';
// import 'package:provider/provider.dart';

// class ScriptsScreen extends StatefulWidget {
//   static final String routeName = "/routeName";
//   @override
//   _ScriptsScreenState createState() => _ScriptsScreenState();
// }

// class _ScriptsScreenState extends State<ScriptsScreen> {
//   bool isFav = false;
//   Repo loadedRepo;
//   @override
//   Widget build(BuildContext context) {
//      final repoId =
//               ModalRoute.of(context).settings.arguments as String; // is the id!
//           loadedRepo = Provider.of<RepoProvider>(
//             context,
//             listen: false,
//           ).findById(repoId);
//     return Scaffold(
//       drawer: AppDrawer(),
//       floatingActionButton: FloatingActionButton(
        
//         child: Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: Text("Open Source Cinema"),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.blue[200],
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(right: 28),
//                   color: Colors.white,
//                   alignment: Alignment.centerRight,
//                   height: 40,
//                   width: 60,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       RaisedButton(
//                         onPressed: () {
//                           // Navigator.of(context)
//                           //     .pushNamed(NewScript.routeName);
//                           Provider.of<RepoProvider>(
//                             context,
//                             listen: false,
//                           ).forkRepo(loadedRepo);
//                           return showDialog(
//                             context: context,
//                             builder: (ctx) => AlertDialog(
//                               title: Text("Yippee!!"),
//                               content: Text(
//                                   "Shelf Forked!!\nGo to My profiles->My shelf to add bits and pieces to this forked shelf"),
//                               actions: <Widget>[
//                                 FlatButton(
//                                   onPressed: () {
//                                     Navigator.of(ctx).pop();
//                                   },
//                                   child: Text("Okay"),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         child: Text("Fork"),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Container(
//                 //   child: Column(
//                 //     children: [
//                 //       Text(loadedRepo.title),
//                 //       Text(loadedRepo.description),
//                 //       Text(loadedRepo.genre),
//                 //     ],
//                 //   ),
//                 // ),
//                 Expanded(
//                   child: loadedRepo.script.length <= 0
//                       ? Container(
//                           child: Text('sexy sexy sexy'),
//                         )
//                       : ListView.builder(
//                           itemExtent: 100,
//                           itemCount: loadedRepo.script.length,
//                           itemBuilder: (ctx, i) {
//                             // if (i == 0) {
//                             // return
//                             // }
//                             return Container(
//                               color: Colors.white54,
//                               width: MediaQuery.of(context).size.width,
//                               child: InkWell(
//                                 child: Card(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 18.0, top: 18.0),
//                                     child: ListTile(
//                                       leading: Text(
//                                         loadedRepo.script[i].title,
//                                         style: TextStyle(
//                                             fontSize: 30, color: Colors.grey),
//                                       ),
//                                       trailing: Container(
//                                         width: 100,
//                                         child: Row(
//                                           children: [
//                                             IconButton(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 18),
//                                               icon: Icon(
//                                                 isFav
//                                                     ? Icons.favorite
//                                                     : Icons.edit,
//                                                 size: 25,
//                                                 color: Colors.grey,
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   // isFav = !isFav;
//                                                 });
//                                               },
//                                             ),
//                                             IconButton(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 18),
//                                               icon: Icon(
//                                                 isFav
//                                                     ? Icons.favorite
//                                                     : Icons
//                                                         .remove_red_eye_outlined,
//                                                 size: 25,
//                                                 color: Colors.blue[800],
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   // isFav = !isFav;
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   debugPrint("pressed");
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
