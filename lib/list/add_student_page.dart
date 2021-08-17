import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hq/test/home_page.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key key, this.imageURL}) : super(key: key);
  final String imageURL;
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var profile = "";
  var time = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final profileController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    profileController.dispose();
    timeController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    profileController.clear();
    timeController.clear();
  }

  // Adding Student
  CollectionReference people = FirebaseFirestore.instance.collection('pika');

  Future<void> addUser() {
    return people
        .add({
          'name': name,
          'profile': profile,
          'time': time,
          'img':
              "https://firebasestorage.googleapis.com/v0/b/home-321408.appspot.com/o/normal.png?alt=media&token=3dc2582f-1378-4676-8dd8-299d65614b93"
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageURL.isNotEmpty) {
      final _newImage = widget.imageURL;
      profileController.value = TextEditingValue(text: _newImage);
    } else {
      profileController.value = TextEditingValue(text: "please upload the pic");
    }
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection('pika').snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'name: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'profile: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: profileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'time: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: timeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                name = nameController.text;
                                profile = profileController.text;
                                time = timeController.text;
                                addUser();
                                clearText();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              });
                            }
                          },
                          child: Text(
                            '登録',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {clearText()},
                          child: Text(
                            '初期化',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
