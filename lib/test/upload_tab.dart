import 'package:flutter/material.dart';
import 'package:hq/test/action_bar.dart';

class UploadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Upload Tab"),
          ),
          ActionBar(
            title: "Upload page",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
