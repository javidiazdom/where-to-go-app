import 'package:flutter_test/flutter_test.dart';
import 'package:app/infraestructure/view/Pages/HomeScreen.dart';
import 'package:app/infraestructure/view/widgets/Panel.dart';
import 'package:app/infraestructure/view/widgets/PlaceDisplay.dart';
import 'package:app/infraestructure/view/widgets/SearchBox.dart';
import 'package:app/infraestructure/view/map/MapWidget.dart';
import '../__utils.dart';

void main() {
  testWidgets('HomeScreen displays SearchBox widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(HomeScreen()));
    expect(find.byType(SearchBox), findsOneWidget);
  });
  testWidgets('HomeScreen displays map widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(HomeScreen()));
    expect(find.byType(MapWidget), findsOneWidget);
  });
  testWidgets('HomeScreen displays PlaceDispay widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetWithContext(HomeScreen()));
    expect(find.byType(PlaceDisplay), findsOneWidget);
  });
}
