import 'package:flutter/material.dart';
import 'package:hq/test/action_bar.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Search Tab"),
          ),
          ActionBar(
            title: "Search page",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
