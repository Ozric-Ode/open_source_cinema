import 'package:flutter/material.dart';
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

  );
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      child: Form(
          key: _form,
          child: ListView(children: <Widget>[
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
                _newRepo = Repo(
                  title: value,
                  description: _newRepo.description,
                  authorId: _newRepo.authorId,
                  

                );
                
              },
            ),
          ])),
    ));
  }
}
