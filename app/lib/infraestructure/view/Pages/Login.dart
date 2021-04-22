import 'dart:ui';

//import '../constants/ProyectColors.dart';
import '../widgets/LoginForm.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: Container(
                  color: Color(0xff191A1A),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 400,
                  height: 350,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Bacteria.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                height: 650,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40, sigmaY: 470),
                    child: Container(
                      height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                          color: Color(0xff343332).withOpacity(0.8)),
                    ),
                  ),
                ),
              ),
              LoginFormContainer(),
            ],
          ),
        ));
  }
}

class LoginFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        AppBar(backgroundColor: Colors.transparent, elevation: 0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Text(
              "Entrar",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        LoginForm(),
      ],
    ));
  }
}
