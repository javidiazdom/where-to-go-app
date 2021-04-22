import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/Pages/Login.dart';
import 'package:app/infraestructure/view/widgets/LoginForm.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Login page displays entrar text and button',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: LoginFormContainer())));
    expect(find.text('Entrar'), findsWidgets);
  });

  testWidgets('Login page displays login form widget',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: LoginFormContainer())));

    expect(find.byType(LoginForm), findsOneWidget);
  });
}
