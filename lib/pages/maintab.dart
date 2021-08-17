import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hq/pages/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hq/main.dart';

void main() => runApp(MainTab());

final dummySnapshot = [
  {"name": "田中", "votes": 15},
  {"name": "伊藤", "votes": 14},
  {"name": "佐藤", "votes": 13},
  {"name": "加藤", "votes": 12},
];

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  File imageFile;
  var _formKey = GlobalKey<FormState>();
  String name, material, price;
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
        body: Scaffold(
          backgroundColor: Colors.amber[800],
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                    child: imageFile == null
                        ? TextButton(
                            onPressed: () {
                              _showDialog();
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.indigo,
                              size: 50,
                            ))
                        : Image.file(
                            imageFile,
                            width: 200,
                            height: 200,
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 1,
                          child: Theme(
                              data: ThemeData(hintColor: Colors.indigo),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "名前を入力してください";
                                  } else {
                                    name = value;
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "名前",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                ),
                              ))),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 1,
                          child: Theme(
                              data: ThemeData(hintColor: Colors.indigo),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "内容を入力してください";
                                  } else {
                                    material = value;
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "内容",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                ),
                              ))),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 1,
                          child: Theme(
                              data: ThemeData(hintColor: Colors.indigo),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "時間を入力してください";
                                  } else {
                                    price = value;
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "時間",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 1)),
                                ),
                              ))),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.indigo[900])),
                      )),
                      onPressed: () {
                        if (imageFile == null) {
                          Fluttertoast.showToast(
                              msg: "画像を選んでください",
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 2);
                        } else {
                          upload();
                        }
                      },
                      child: Text(
                        "アップロード",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("どこから写真を読み込みますか？"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("ギャラリー"),
                    onTap: () {
                      openGallary();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  GestureDetector(
                    child: Text("カメラ"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> openGallary() async {
    final picker = ImagePicker();
    XFile pickedFile = await picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    XFile pickedFile = await picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  Future<void> upload() async {
    if (_formKey.currentState.validate()) {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageFile.path);
      UploadTask uploadTask = reference.putFile(imageFile);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      var url = imageUrl.toString();
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("Data");
      String uploadId = databaseReference.push().key;
      HashMap map = new HashMap();
      map["name"] = name;
      map["material"] = material;
      map["price"] = price;
      map["url"] = url;
      databaseReference.child(uploadId).set(map);
    }
  }
}
