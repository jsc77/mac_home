import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hq/test/constant.dart';
import 'package:hq/pages/home_screen.dart';
import 'package:hq/pages/login.dart';
import 'package:hq/test/helper.dart';
import 'package:hq/test/home_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                      body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ));
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User _user = streamSnapshot.data;
                  if (_user == null) {
                    return Login();
                  } else {
                    return HomePage();
                  }
                }

                return Scaffold(
                  body: Container(
                    width: Helper.getScreenWidth(context),
                    height: Helper.getScreenHeight(context),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(Helper.getAssetName("pika.png")),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity * 0.5,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(children: [
                              Flexible(child: Text("HAPPY DAY!")),
                              Spacer(),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Text(
              "Initialization App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
