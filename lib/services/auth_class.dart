import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hq/pages/home_screen.dart';
import 'package:hq/services/dm.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      if (googleSignInAccount != null) {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        await DM().createUserData(userCredential.user.displayName, "guest", 100,
            userCredential.user.uid);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomeScreen()),
            (route) => false);

        final snackBar = SnackBar(
            backgroundColor: Colors.white,
            duration: Duration(seconds: 3),
            content: Row(
              children: [
                Icon(
                  Icons.face_outlined,
                  color: Colors.indigo[800],
                ),
                SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "ようこそ！",
                  style: TextStyle(
                      fontFamily: "Kyo",
                      color: Colors.indigo[800],
                      fontSize: 20),
                ))
              ],
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("here---->");
      final snackBar = SnackBar(content: Text("エラー発生です"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut({BuildContext context}) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      final snackBar = SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          content: Row(
            children: [
              Icon(
                Icons.logout_outlined,
                color: Colors.indigo[800],
              ),
              SizedBox(width: 20),
              Expanded(
                  child: Text(
                "ご利用ありがとうございました。",
                style: TextStyle(
                    fontFamily: "Kyo", color: Colors.indigo[800], fontSize: 20),
              ))
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
