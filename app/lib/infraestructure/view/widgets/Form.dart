import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.person, color: Colors.white)),
              controller: usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduzca un email';
                }
                return null;
              },
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    )),
                controller: passwordController,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca la contraseña';
                  }
                  return null;
                }),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () => {},
                  child: Text(
                    "¿Has olvidado tu contraseña?",
                    style: TextStyle(color: Color(0xff21ABAB)),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => {},
                  child: Text("Entrar"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith<Size>(
                          (states) => Size(300.0, 35.0)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => Color(0xff21ABAB)))),
            ),
            SizedBox(height: 15.0),
            Center(
                child: InkWell(
                    onTap: () => {},
                    child: Text(
                      "¿No tienes una cuenta? Regístrate",
                      style: TextStyle(color: Color(0xff21ABAB)),
                    )))
          ],
        ),
      ),
    );
  }
}
