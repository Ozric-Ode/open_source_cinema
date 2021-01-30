import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  Map<String, dynamic> umap;
  Future<void> getuser(BuildContext context) async {
    final authUserId = Provider.of<Auth>(context, listen: false).authUserId;
    print("Authuserid-- ${authUserId}");
    umap = await User.fetchUser(authUserId);
    print(umap);
  }

  @override
  Widget build(BuildContext context) {
    getuser(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("umap['name']"),
            accountEmail: Text("umap['email']"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.shop),
          //   title: Text('Shop'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text('Orders'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(OrdersScreen.routeName);
          //     // Navigator.of(context).pushReplacement(
          //     //   CustomRoute(
          //     //     builder: (ctx) => OrdersScreen(),
          //     //   ),
          //     // );
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Manage Products'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(UserProductsScreen.routeName);
          //   },
          // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
