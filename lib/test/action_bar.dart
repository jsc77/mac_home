import 'package:flutter/material.dart';
import 'package:hq/test/constant.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  ActionBar({this.title, this.hasBackArrow});

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    return Container(
      padding: EdgeInsets.only(top: 72, left: 24, right: 24, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            Container(
              child: Image(
                image: AssetImage("assets/smiley.png"),
                width: 20,
              ),
            ),
          Text(
            title ?? "Action Bar",
            style: Constants.regularHeading,
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(
              "0",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
