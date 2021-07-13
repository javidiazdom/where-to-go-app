import 'dart:math';

import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/view/widgets/PlaceDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../__utils.dart';

void main() {
  group('Place display widget', () {
    testWidgets('displays nothing while place is not set',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetWithContext(PlaceDisplay()));
      expect(find.textContaining(RegExp("/.+")), findsNothing);
    });
  });
}
