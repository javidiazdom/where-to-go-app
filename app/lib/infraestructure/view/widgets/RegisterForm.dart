import 'package:app/infraestructure/view/widgets/AlertDialog.dart';
import 'package:flutter/material.dart';
import '../../../domain/services/Credentials.service.dart';

import '../../../domain/models/Credentials.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: "Nombre"),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca su nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: "Email"),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca un email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    focusColor: Colors.white,
                  ),
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
              SizedBox(height: 20.0),
              TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    focusColor: Colors.white,
                  ),
                  controller: confirmPasswordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Introduzca la contraseña';
                    }
                    if (value != passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  }),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        RegisterCredentials credentials =
                            new RegisterCredentials(emailController.text,
                                nameController.text, passwordController.text);
                        try {
                          await CredentialsService.register(credentials);
                          // redirigir a otra página indicando que el login ha sido correcto?
                          Navigator.of(context).pop();
                        } on Exception catch (error) {
                          await CustomAlertDialog.showCustomDialog(
                              context, error.toString());
                        }
                      }
                    },
                    child: Text("Entrar"),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith<Size>(
                            (states) => Size(300.0, 35.0)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    Color(0xff21ABAB)))),
              ),
            ],
          ),
        ));
  }
}
