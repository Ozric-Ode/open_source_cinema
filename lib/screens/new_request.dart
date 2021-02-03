import 'package:flutter/material.dart';
import 'package:open_source_cinema/models/repo.dart';
import 'package:open_source_cinema/models/request.dart';
import 'package:open_source_cinema/models/scripts.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:provider/provider.dart';

class NewRequest extends StatefulWidget {
  static final String routeName = '/newRequest';
  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _form = GlobalKey<FormState>();
  var _newReq =
      Request(parentRepoId: "", childRepoId: "", requestMessage: "", title: "");

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    _form.currentState.reset();

    try {
      Provider.of<RepoProvider>(context, listen: false).addRequest(_newReq);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadedrepo = ModalRoute.of(context).settings.arguments as Repo;
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Your requests"),
      ),
      drawer: AppDrawer(),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print("Title $value");
                        _newReq = Request(
                            parentRepoId: loadedrepo.parentRepoId,
                            childRepoId: loadedrepo.authorId,
                            requestMessage: _newReq.requestMessage,
                            title: value);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Request Message'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // print("Genre $value");
                        _newReq = Request(
                            parentRepoId: loadedrepo.parentRepoId,
                            childRepoId: loadedrepo.authorId,
                            requestMessage: value,
                            title: _newReq.title);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                _saveForm();
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Congrats!!"),
                    content: Text("request sent!!!!!!!"),
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
              child: Text('send request'))
        ],
      )),
    );
  }
}
