import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Source Cinema',
      home: Scaffold(
        appBar: AppBar(title: Text('Open Source Cinema')),
      ),
    );
  }
}