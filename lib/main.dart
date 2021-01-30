import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/screens/repo_overview.dart';
import 'package:provider/provider.dart';
import 'package:open_source_cinema/screens/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => RepoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Open Source Cinema',
       // home: RepoOverview()
        home:UserScreen(),
      ),
    );
  }
}
