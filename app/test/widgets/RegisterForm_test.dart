import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/widgets/RegisterForm.dart';

Widget createRegisterFormWidgetWithContext() {
  return MaterialApp(home: Scaffold(body: RegisterForm()));
}

void main() {
  group('Register form', () {
    testWidgets(
        'displays name, email, password and password confirmation text inputs',
        (WidgetTester tester) async {
      await tester.pumpWidget(createRegisterFormWidgetWithContext());
      expect(find.byType(TextFormField), findsNWidgets(4));
    });
  });
}
