import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

Future speak(String s) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(s);
}
