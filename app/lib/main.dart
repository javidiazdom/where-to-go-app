import 'package:flutter/material.dart';
import 'package:app/infraestructure/view/Pages/Login.dart';

void main(List<String> args) {
  runApp(WhereToGo());
}

class WhereToGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: LoginPage(),
    );
  }

  ThemeData themeData() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))));
  }
}
