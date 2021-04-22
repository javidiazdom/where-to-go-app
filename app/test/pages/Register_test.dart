import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/Pages/Register.dart';

Widget createRegisterWidgetWithContext() {
  return MaterialApp(home: Scaffold(body: Register()));
}

void main() {
  testWidgets('Register page displays register text',
      (WidgetTester tester) async {
    await tester.pumpWidget(createRegisterWidgetWithContext());
    expect(find.text('Registro'), findsOneWidget);
  });
}
