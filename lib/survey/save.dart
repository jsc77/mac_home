import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hq/survey/database.dart';
import 'package:hq/survey/widgets.dart';

class Save extends StatefulWidget {
  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter the Image!" : null,
                decoration: InputDecoration(hintText: "Quiz Image Url"),
                onChanged: (val) {
                  quizImageUrl = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter the Title!" : null,
                decoration: InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  quizImageUrl = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter the Image!" : null,
                decoration: InputDecoration(hintText: "Quiz description"),
                onChanged: (val) {
                  quizImageUrl = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              blueButton(context, "Quiz"),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
