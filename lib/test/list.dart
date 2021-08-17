import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hq/list/update_student_page.dart';

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('pika').snapshots();
  CollectionReference people = FirebaseFirestore.instance.collection('pika');
  Future<void> deleteUser(id) {
    return people
        .doc(id)
        .delete()
        .then((value) => print('削除'))
        .catchError((error) => print('削除失敗：$error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something worng');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
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
          final List storedocs = [];
          snapshot.data.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          storedocs.sort((a, b) {
            return b['time'].compareTo(a['time']);
          });
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(0.4),
                  1: FlexColumnWidth(0.2),
                  2: FlexColumnWidth(0.2),
                  3: FlexColumnWidth(0.6),
                  4: FlexColumnWidth(0.6),
                },
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      height: 50,
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          '写真',
                          style: TextStyle(
                              fontFamily: 'Kyo',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      height: 50,
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          '名前',
                          style: TextStyle(
                              fontFamily: 'Kyo',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      height: 50,
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          '部屋',
                          style: TextStyle(
                              fontFamily: 'Kyo',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      height: 50,
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          '編集',
                          style: TextStyle(
                              fontFamily: 'Kyo',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    )),
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                        child: Container(
                          height: 50,
                          color: Colors.orangeAccent,
                          child: Image(
                            image: AssetImage("assets/${storedocs[i]['img']}"),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 50,
                          color: Colors.orangeAccent,
                          child: Center(
                            child: Text(
                              storedocs[i]['name'],
                              style: TextStyle(
                                  fontFamily: 'Ryo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          child: Container(
                        height: 50,
                        color: Colors.orangeAccent,
                        child: Center(
                          child: Text(
                            storedocs[i]['time'],
                            style: TextStyle(
                                fontFamily: 'Ryo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                        ),
                      )),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateStudentPage(
                                                    id: storedocs[i]['id']),
                                          ))
                                    },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.indigo,
                                )),
                            IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    ]),
                  ]
                ],
              ),
            ),
          );
        });
  }
}
