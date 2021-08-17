import 'package:flutter/material.dart';

class NoAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "アクセス権限がありません。",
              style: TextStyle(
                  fontSize: 20, fontFamily: "Kyo", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
