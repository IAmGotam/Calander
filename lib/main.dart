import 'package:calender/Calendar_Screen.dart';
// import 'package:fancy_radio_button/fancy_radio_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Calendar_Screen(),
    );
  }
}
