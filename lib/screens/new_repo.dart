import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:provider/provider.dart';

import '../models/repo.dart';

class NewRepo extends StatefulWidget {
  @override
  _NewRepoState createState() => _NewRepoState();
}

class _NewRepoState extends State<NewRepo> {
  final _form = GlobalKey<FormState>();
  var _newRepo = Repo(
    title: '',
    description: '',
    authorId: '',
    parentRepoId: '',
    repoId: '',
    genre: '',
  );

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    _form.currentState.reset();

    try {
      await Provider.of<RepoProvider>(context, listen: false).addRepo(_newRepo);
    } catch (e) {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      _newRepo = Repo(
                        title: value,
                        description: _newRepo.description,
                        authorId: _newRepo.authorId,
                        parentRepoId: _newRepo.parentRepoId,
                        repoId: _newRepo.repoId,
                        genre: _newRepo.genre,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Genre'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      print("Genre $value");
                      _newRepo = Repo(
                        title: _newRepo.title,
                        description: _newRepo.description,
                        authorId: _newRepo.authorId,
                        parentRepoId: _newRepo.parentRepoId,
                        repoId: _newRepo.repoId,
                        genre: value,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      print("Des $value");
                      _newRepo = Repo(
                          title: _newRepo.title,
                          description: value,
                          authorId: _newRepo.authorId,
                          parentRepoId: _newRepo.parentRepoId,
                          repoId: _newRepo.repoId,
                          genre: _newRepo.genre);
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
                content: Text("New Shelf added!!\nGo to My profiles->My shelves to add bits and pieces into your brand new shelf"), 
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
          child: Text('Create New Shelf'))
    ],
      ),
    );
  }
}
