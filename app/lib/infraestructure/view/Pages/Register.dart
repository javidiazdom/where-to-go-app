import 'package:flutter/material.dart';
import '../widgets/RegisterForm.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Container(color: Color(0xff2F2E2D)),
            ),
            RegisterFormContainer(),
          ],
        ),
      ),
    );
  }
}

class RegisterFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => {Navigator.of(context).pop(true)},
          )),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            "Registro",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
      RegisterForm()
    ]));
  }
}
