import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/scripts_provider.dart';
import 'package:open_source_cinema/screens/new_script.dart';
import 'package:open_source_cinema/screens/scripts_screen.dart';
import 'package:provider/provider.dart';
import 'package:open_source_cinema/screens/user_screen.dart';

import './providers/repo_provider.dart';
import './screens/auth_screen.dart';
import './screens/home.dart';
import './providers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth autho = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, RepoProvider>(
            create: null,
            update: (ctx, auth, previousRepo) => RepoProvider(
              auth.token,
              auth.userId,
              previousRepo == null ? [] : previousRepo.repo,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Open Source Cinema',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                // ? Scaffold(
                //   appBar: AppBar(title: Text("Open Source Cinema"),),
                //     body: Center(
                //       child: FlatButton(
                //         child: Text("Log out"),
                //         onPressed: () {
                //           auth.logout();
                //         },
                //       ),
                //     ),
                //   )
                ?ScriptsScreen()// Home()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : AuthScreen(),
                  ),
            // home: new StreamBuilder(
            //   stream: autho.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return ProductsOverviewScreen();
            //     }
            //     return AuthenticationScreen(); // MyHomePage(title: 'Flutter Demo Home Page'),
            //   },
            // ),
            routes: {
              NewScript.routeName:(context)=>NewScript(),
            },
          ),
        ));

  }
}
