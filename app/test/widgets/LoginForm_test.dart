import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/widgets/LoginForm.dart';

Widget createFormWithContext() {
  return MaterialApp(home: Scaffold(body: LoginForm()));
}

void main() {
  testWidgets('Login form displays two text input displays',
      (WidgetTester tester) async {
    await tester.pumpWidget(createFormWithContext());
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
  testWidgets('Login form displays the submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createFormWithContext());
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('Login form displays the forgot password text',
      (WidgetTester tester) async {
    await tester.pumpWidget(createFormWithContext());
    expect(find.text('¿Has olvidado tu contraseña?'), findsOneWidget);
  });
}
