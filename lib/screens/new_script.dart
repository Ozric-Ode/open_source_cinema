import 'package:flutter/material.dart';
import 'package:open_source_cinema/widgets/drawer.dart';

class NewScript extends StatefulWidget {
  static final String routeName = '/newScript';
  @override
  _NewScriptState createState() => _NewScriptState();
}

class _NewScriptState extends State<NewScript> {
  String data;
  TextEditingController _dataController = new TextEditingController();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Source Cinema"),
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bring your ideas on Paper"),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(vertical: 12),
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
              maxLength: 40,
              decoration: InputDecoration(counterText: ''),
              controller: _dataController,
              autocorrect: true,
              maxLines: 30,
              onEditingComplete: () {
                setState(() {
                  data = _dataController.text;
                });
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () {
              print(_key.currentState.value);
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
