import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hq/customClipper.dart';

class CustomBottomNavig extends StatefulWidget {
  final int active;
  CustomBottomNavig(this.active);

  @override
  _CustomBottomNavigState createState() => _CustomBottomNavigState();
}

class _CustomBottomNavigState extends State<CustomBottomNavig> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomCustomClipper(),
        child: Stack(
          children: [
            Container(
              color: Colors.orange,
              height: 120,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("home");
                            },
                            icon: Icon(Icons.home_filled, color: Colors.white)),
                        Container(
                          color: widget.active == 0 ? Colors.red : Colors.black,
                          width: 50,
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("search");
                            },
                            icon: Icon(Icons.search, color: Colors.white)),
                        Container(
                          color: widget.active == 1 ? Colors.red : Colors.black,
                          width: 50,
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("profile");
                            },
                            icon: Icon(Icons.person_outline,
                                color: Colors.white)),
                        Container(
                          color: widget.active == 2 ? Colors.red : Colors.black,
                          width: 50,
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
