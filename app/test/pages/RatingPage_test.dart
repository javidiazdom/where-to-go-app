import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/view/Pages/RatingPage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/constants/RatingDescriptionData.dart';
import '../__utils.dart';

void main() {
  testWidgets('RatingPage displays ratings descriptions',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(
        RatingPage(new Place("", 0, new PlaceLatLng(0, 0)))));
    expect(find.text(descriptions[0].description), findsOneWidget);
  });
  testWidgets('Rating page shows place name', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(
        RatingPage(new Place("Place name", 0, new PlaceLatLng(0, 0)))));
    expect(find.text("Añadir una valoración sobre Place name"), findsOneWidget);
  });
}
