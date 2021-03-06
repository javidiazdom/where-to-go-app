import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/widgets/LoginForm.dart';
import '../__utils.dart';

void main() {
  testWidgets('Login form displays two text input displays',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(LoginForm()));
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
  testWidgets('Login form displays the submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(LoginForm()));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
