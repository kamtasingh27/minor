import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'api.dart';
import 'area.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'controls.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            title: Text('fuckthis'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: buildImage()),
                      const SizedBox(height: 16),
                      ControlsWidget(
                        onClickedPickImage: pickImage,
                        onClickedScanText: scanText,
                        onClickedClear: clear,
                      ),
                      const SizedBox(height: 16),
                      TextAreaWidget(
                        text: text,
                        onClickedCopy: copyToClipboard,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
      );

Widget buildImage() => Container(
    child: image != null
        ? Image.file(image)
        : Icon(Icons.photo, size: 80, color: Colors.black),
  );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      context: context,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);

    Navigator.of(context).pop();
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}