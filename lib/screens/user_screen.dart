import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:open_source_cinema/screens/fork_repo.dart';
import 'package:open_source_cinema/screens/own_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'dart:async';
import '../providers/auth.dart';

class UserScreen extends StatelessWidget {
  User obj = new User(email: "", name: "", userId: "asdsadasdsad");
  String initavatar = " ";
  User userObj = new User();
  Future<void> getuser(BuildContext context) async {
    final authUserId = Provider.of<Auth>(context, listen: true).authUserId;
    print("Authuserid-- ${authUserId}");

    obj = await User.fetchUser(authUserId);
    initavatar = obj.name.substring(0, 1).toUpperCase();
    print('Lawda ki jhaant ${obj.name}  ${obj.email} ${obj.userId}');
  }

  @override
  Widget build(BuildContext context) {
    getuser(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Open Source Cinema'),
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[

          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
              ),
            ),
            child: Center(
              child:FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 400)),
                builder: (context, snapshot) {
                 return Text(
                    initavatar,
                    style: TextStyle(fontSize: 40.0),
                  );
                },
              ),
                  // Image.network('https://googleflutter.com/sample_image.jpg'),
            ),
          ),
          //  BoxDecoration(
          //   image: DecorationImage(
          //     image:AssetImage("FlutterLogo(size: 56.0)"),

          //     fit:BoxFit.fill,
          //   ),
          //   shape: BoxShape.circle,
          // ),
          //   ),
          //   ],
          // ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500)),
            builder: (context, snapshot) {
              // if(snapshot.hasData)
              return Text(
                "Hi, ${obj.name}",
                style: TextStyle(
                  // Theme.of(context).textTheme.headline4,
                  fontSize: 26.0,
                  //  fontWeight: FontWeight.w100 ,
                  foreground: Paint()..color = Colors.teal,
                ),
              );
            },
          ),

          SizedBox(
            height: 10,
          ),
          
            FlatButton(
              
              onPressed: ()
              {
                Navigator.of(context)
              .pushNamed(ForkRepo.routename);

               },
               child: Container( 
                width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height*(1/10),
            child:Text("my fork repos"),
            ),
            ),

             FlatButton(
              
              onPressed: ()
              {
               Navigator.of(context)
              .pushNamed(OwnRepo.routename);
               },
               child: Container( 
                width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height*(1/10),
            child:Text("my own repos"),
            ),
            ),

          
          // Flexible(
          //   child: RepoList(1),
          // ),
        ],
      ),
      // ),
    );
  }
}
