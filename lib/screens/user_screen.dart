import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Open Source Cinema'),
        backgroundColor: Colors.deepPurple,
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:50),
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
                    child: Image.network(
                        'https://googleflutter.com/sample_image.jpg'),
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
            Text(
              "Hi, username",
              style: TextStyle(
                // Theme.of(context).textTheme.headline4,
                fontSize: 26.0,
                //  fontWeight: FontWeight.w100 ,
                foreground: Paint()..color = Colors.teal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: RepoList(),
            ),
          ],
        ),
      // ),
    );
  }
}
