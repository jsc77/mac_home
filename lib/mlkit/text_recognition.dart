import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hq/mlkit/text_recognition_detail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class TextRecognition extends StatefulWidget {
  @override
  _TextRecognitionState createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(onPressed: scanText, child: Text("Scan"))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null
              ? Image.file(File(_image.path), fit: BoxFit.fitWidth)
              : Container()),
    );
  }

  Future scanText() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + "¥n";
      }
    }
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TextRecognitionDetail(_text)));
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile as PickedFile;
      } else {
        print("no image selected");
      }
    });
  }
}
