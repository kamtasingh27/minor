import 'package:flutter/material.dart';
import 'package:minor/currency.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'face.dart';
import 'tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minor',
      debugShowCheckedModeBanner: false,
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}
class _SpeechScreenState extends State<SpeechScreen> {

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Touch anywhere and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    speak("What do you want to do?");
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accuracy: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () {
          return _listen();
        },
        child: Container(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            if(_text.contains('around') || _text.contains('front')) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => face()));
            }
            else if (_text.contains('currency') ) {
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => currency()));
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}