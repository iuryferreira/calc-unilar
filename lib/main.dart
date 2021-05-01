import 'package:calc_unilar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'screens/calc_screen.dart';
import 'screens/result_page.dart';

void main() => runApp(CalcUnilar());

class CalcUnilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff111111),
        scaffoldBackgroundColor: Color(0xff111111),
        hintColor: kIconSelected,
        accentColor: kIconSelected
      ),
      routes: {
        "/results": (context) => ResultPage(),
      },
      debugShowCheckedModeBanner: false,
      home: InputPage(),
    );
  }
}

