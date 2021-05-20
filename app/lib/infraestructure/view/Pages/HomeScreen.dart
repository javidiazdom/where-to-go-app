import 'package:app/infraestructure/view/widgets/Panel.dart';
import 'package:flutter/material.dart';
import 'package:app/infraestructure/view/map/MapInteraction.dart';
import '../map/MapWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  MapInteraction mapInteraction = new MapInteraction();

  Widget build(BuildContext context) {
    return Stack(children: [MapWidget(mapInteraction), Panel(mapInteraction)]);
  }
}
