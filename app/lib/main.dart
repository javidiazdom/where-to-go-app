import 'package:flutter/material.dart';
import 'package:app/infraestructure/view/Pages/Login.dart';
import 'package:app/infraestructure/view/constants/Theme.dart';

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
}
