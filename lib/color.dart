import 'package:flutter/material.dart';
import "package:tflite/tflite.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'tts.dart';


class color extends StatefulWidget {
  @override
  _colorState createState() => _colorState();
}

class _colorState extends State<color> {
  File _image;
  List _outputs;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    speak('Click anywhere to open the camera and take a photo');
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Color Recognition',
          style: TextStyle(
            fontFamily: 'nerko',
            fontSize: 30,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Expanded(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Click anywhere to open the Camera',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'nerko'
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ): Image.file(_image),
            _outputs != null
                ? Text(
              "${_outputs[0]["label"]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }


  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState (() {
      _loading = false;
      _outputs = output;
    });
    if (_outputs!=null)
      {speak("this seems to be ${_outputs[0]["label"].toString().substring(2)} color");
      Navigator.pop(context);
      Navigator.pop(context);


      }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant2.tflite",
      labels: "assets/labels2.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}