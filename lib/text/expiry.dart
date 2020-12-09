import 'dart:io';
import 'api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minor/tts.dart';

class Expiry extends StatefulWidget {
  const Expiry({
    Key key,
  }) : super(key: key);

  @override
  _ExpiryState createState() => _ExpiryState();
}

class _ExpiryState extends State<Expiry> {
  String _text = '';
  File image;
  bool _loading = false;
  String out='';

  static DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'Expiry Date',
            style: TextStyle(
              fontFamily: 'nerko',
              fontSize: 30,
              color: Colors.red,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body:_loading
            ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
            : Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image == null ? Expanded(
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
                ): Column(
                  children: [
                    Image.file(image),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      out + '''
                      Today's Date : ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'nerko',
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ],
          ),
        ),
      );


  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
    scanText();
  }

  Future scanText() async {
    final text = await FirebaseMLApi.recogniseText(image);
    setState (() {
      _text = text;
      _loading = false;
    });
    if (_text!=null)
    {
      if(_text.contains('Exp Date'))
      {
        int index = _text.indexOf('Exp');
        var ans = _text.substring(index,index+17);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('exp date'))
      {
        int index = _text.indexOf('exp');
        var ans = _text.substring(index,index+17);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('EXP DATE'))
      {
        int index = _text.indexOf('EXP');
        var ans = _text.substring(index,index+17);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('Expiry Date'))
      {
        int index = _text.indexOf('Expiry Date');
        var ans = _text.substring(index,index+20);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('Exp. Date'))
      {
        int index = _text.indexOf('Exp. Date');
        var ans = _text.substring(index,index+18);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('expiry'))
      {
        int index = _text.indexOf('expiry date');
        var ans = _text.substring(index,index+20);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('EXPIRY DATE'))
      {
        int index = _text.indexOf('EXPIRY DATE');
        var ans = _text.substring(index,index+20);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('Exp'))
      {
        int index = _text.indexOf('Exp');
        var ans = _text.substring(index,index+12);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('exp'))
      {
        int index = _text.indexOf('exp');
        var ans = _text.substring(index,index+12);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('EXP'))
      {
        int index = _text.indexOf('EXP');
        var ans = _text.substring(index,index+12);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('Expiry'))
      {
        int index = _text.indexOf('Expiry');
        var ans = _text.substring(index,index+15);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('expiry'))
      {
        int index = _text.indexOf('expiry');
        var ans = _text.substring(index,index+15);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else if(_text.contains('EXPIRY'))
      {
        int index = _text.indexOf('EXPIRY');
        var ans = _text.substring(index,index+15);
        out=ans;
        speak(ans + '''And Today's Date ''' + date.day.toString() + ' ' + date.month.toString()+' '+date.year.toString());
      }
      else
      {
        speak('No expiry date found. Please try taking another photo from another side or angle.');
        out = 'No expiry date found. Please try taking another photo from another side or angle.';
      }
    }
  }


  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }
}