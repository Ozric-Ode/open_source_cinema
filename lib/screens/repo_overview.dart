import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:open_source_cinema/widgets/drawer.dart';
import 'package:open_source_cinema/widgets/repo_list.dart';
import 'package:open_source_cinema/widgets/repo_tile.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/filterchip.dart';

class RepoOverview extends StatelessWidget {
  // Future<void> fun() async {
  //   final dbRef = FirebaseDatabase.instance.reference().child("users");

  //   await dbRef
  //       .orderByChild("userid")
  //       .equalTo("TG3flo3AUseRONcN7ls3Y6RcoKP2")
  //       .once()
  //       .then((DataSnapshot dataSnapshot) {
  //     var newKey = dataSnapshot.value;
  //     var _list = newKey.values.toList();
  //     print(_list);
  //     var _lis = _list[0].values.toList();
  //     print(_lis);
  //     String userAuthid = _lis[1];
  //     print(userAuthid);
  //     newKey.forEach((k, v) => print('${k}'));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(child: FilterChipScreen()),
        // // FilterWidget("comedy"),
        // // SizedBox(width: 40),
        // // FilterWidget("tragedy"),
        // // SizedBox(width: 40),
        // // FilterWidget("sfdfd"),
        // // SizedBox(width: 40),
        // // FilterWidget("cfdoff"),
        // // SizedBox(width: 40),
        // // FilterWidget("cofddfmy"),
        Container(
          height: 50,
          child: FilterChipScreen(),
        ),
        Expanded(child: RepoList(0)),
      ],
    );
  }
}


// Wrap(
//   children: [
//     FilterChip(
//       label: Text('Popcorn'),
//       selected: false,
//       onSelected: (bool selected) {
//         setState(() {});
//       },
//     ),
//     SizedBox(
//       width: 10,
//     ),
//     FilterChip(
//       label: Text('Coke'),
//       labelStyle: TextStyle(
//           color: widget.isSelected ? Colors.black : Colors.white),
//       selected: widget.isSelected,
//       onSelected: (bool selected) {
//         setState(() {
//           widget.isSelected = !widget.isSelected;
//         });
//       },
//       selectedColor: Theme.of(context).accentColor,
//       checkmarkColor: Colors.black,
//     ),
//   ],
// )