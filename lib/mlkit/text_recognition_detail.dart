import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class TextRecognitionDetail extends StatefulWidget {
  final String text;
  TextRecognitionDetail(this.text);
  @override
  _TextRecognitionDetailState createState() => _TextRecognitionDetailState();
}

class _TextRecognitionDetailState extends State<TextRecognitionDetail> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          IconButton(
              onPressed: () {
                FlutterClipboard.copy(widget.text).then((value) => _key
                    .currentState
                    .showSnackBar(new SnackBar(content: Text("copied"))));
              },
              icon: Icon(Icons.copy))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? "Text not available" : widget.text),
      ),
    );
  }
}
