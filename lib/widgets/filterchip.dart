import 'package:flutter/material.dart';
import 'package:open_source_cinema/providers/repo_provider.dart';
import 'package:provider/provider.dart';

class FilterChipScreen extends StatefulWidget {
  @override
  _FilterChipScreenState createState() => _FilterChipScreenState();
}

class _FilterChipScreenState extends State<FilterChipScreen> {
  var data = ['All', 'comedy', 'tragedy', 'fiction', 'poem', 'comics'];
  var selected = [];
  var _defaultChoiceIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(data[index]),
              selected: _defaultChoiceIndex == index,
              selectedColor: Colors.green,
              onSelected: (bool selected) {
                Provider.of<RepoProvider>(context, listen: false)
                    .homerepo(data[index]);
                print(data[index]);
                setState(() {
                  _defaultChoiceIndex = selected ? index : 0;
                });
              },
              backgroundColor: Colors.blue,
              labelStyle: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/repo.dart';
// import '../providers/repo_provider.dart';

// class FilterWidget extends StatefulWidget {
//   String filterText;
//   FilterWidget(this.filterText);

//   @override
//   _FilterWidgetState createState() => _FilterWidgetState();
// }

// class _FilterWidgetState extends State<FilterWidget> {
//   @override
//   Widget build(BuildContext context) {
//     bool _isSelc = false;
//     return FilterChip(
//       // disabledColor: Colors.amber,
//       selectedColor: Colors.redAccent,
//       selected: _isSelc,
//       label: Text(widget.filterText),
//       onSelected: (bool value) {
//         _isSelc = value;
//         setState(() {});
//       },
//     );
//   }
// }
