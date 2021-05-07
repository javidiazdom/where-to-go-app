import 'package:app/infraestructure/view/widgets/Panel.dart';
import 'package:flutter/material.dart';
import '../map/MapWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [MapWidget(), Panel()]);
  }
}
