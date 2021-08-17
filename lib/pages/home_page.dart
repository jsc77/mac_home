import 'package:flutter/material.dart';
import 'package:hq/list/list_student_page.dart';
import 'package:hq/pages/add_student_page.dart';
import 'package:hq/pages/home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> moveToLastScreen() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (cts) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => moveToLastScreen(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrangeAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (cts) => HomeScreen()));
                  }),
              Text(
                '起床一覧',
                style: TextStyle(
                  fontFamily: 'Kyo',
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddStudentPage(),
                    ),
                  )
                },
                child: Text(
                  '追加',
                  style: TextStyle(
                    fontFamily: 'Kyo',
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
              )
            ],
          ),
        ),
        body: ListStudentPage(),
      ),
    );
  }
}
