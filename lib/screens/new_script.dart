import 'package:flutter/material.dart';
import 'package:open_source_cinema/models/repo.dart';
import 'package:open_source_cinema/models/scripts.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:provider/provider.dart';

class NewScript extends StatefulWidget {
  static final String routeName = '/newScript';
  @override
  _NewScriptState createState() => _NewScriptState();
}

class _NewScriptState extends State<NewScript> {
  String repoId;
  var _newRepo = Repo(
    title: '',
    description: '',
    authorId: '',
    parentRepoId: '',
    repoId: '',
    genre: '',
  );
  Scripts _script;
  Scripts scriptDataObj;
  String data, title;
  TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormFieldState> _titleKey = GlobalKey<FormFieldState>();
  TextEditingController _dataController = new TextEditingController();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveForm() async {
    print("fjjdjfjk-------------->>>>>>>>>>>>>>${_script.title}");
    // final isValid = _formKey.currentState.validate();
    // if (!isValid) {
    //   return;
    // }
    // _formKey.currentState.save();
      _formKey.currentState.reset();
    try {
      print("Suuccess");
      await Provider.of<RepoProvider>(context, listen: false).addScript(
        repoId,
        _script,
      );
    } catch (e) {
      print(e.toString());
    }
        Navigator.of(context).pop();
  }

  get newMethod => Provider;

  @override
  Widget build(BuildContext context) {
    repoId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Source Cinema"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bring your ideas on Paper",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  key: _titleKey,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: "Title",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  controller: _titleController,
                  autocorrect: true,
                  maxLines: 1,
                  validator: (val) {
                    if (val.length == 0) return "Title Can't be null";
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                padding: EdgeInsets.only(top: 12, left: 5, right: 5),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  key: _key,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: "Description",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  controller: _dataController,
                  autocorrect: true,
                  maxLines: 30,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                onPressed: () {
                  _script = Scripts(
                      title: _titleKey.currentState.value,
                      content: _key.currentState.value);
                  print("fjjdjfjk-------------->>>>>>>>>>>>>>${_script.content}");
                  _saveForm();
                  print(_titleKey.currentState.value);
                  print(_key.currentState.value);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
