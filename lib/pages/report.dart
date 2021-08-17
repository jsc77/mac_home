import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hq/Data.dart';
import 'package:hq/pages/home_screen.dart';
import 'package:hq/pages/login.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<Data> dataList = [];
  DatabaseReference referenceData =
      FirebaseDatabase.instance.reference().child("Data");
  @override
  void initState() {
    super.initState();

    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Data data = new Data(
          values[key]['url'],
          values[key]['name'],
          values[key]['material'],
          values[key]['price'],
        );
        dataList.add(data);
      }
    });
  }

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
          backgroundColor: Colors.amber[800],
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
                '報告事項',
                style: TextStyle(
                  fontFamily: 'Kyo',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.orange[700],
        body: StreamBuilder(
          stream: referenceData.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.snapshot.value != null) {
              return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (_, index) {
                    return SingleChildScrollView(
                      child: Card(
                        margin: EdgeInsets.all(15),
                        color: Colors.indigo[900],
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.all(1.5),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                dataList[index].url,
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                dataList[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Kyo",
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                "内容： " + dataList[index].material,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Ryo",
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "時間： " + dataList[index].price,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "データ読み込み中",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
