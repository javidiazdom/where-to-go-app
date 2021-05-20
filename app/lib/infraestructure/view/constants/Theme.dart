import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
      fontFamily: 'Heebo',
      accentColor: Color(0xff34C1AD),
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))));
}
