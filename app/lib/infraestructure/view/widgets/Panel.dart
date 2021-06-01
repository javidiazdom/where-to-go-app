import 'dart:ui';

import 'package:app/infraestructure/view/map/MapInteraction.dart';
import 'package:app/infraestructure/view/widgets/PlaceDisplay.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/infraestructure/view/widgets/SearchBox.dart';

class Panel extends StatefulWidget {
  final MapInteraction mapInteraction;
  const Panel(this.mapInteraction);

  @override
  _PanelState createState() => _PanelState(mapInteraction);
}

class _PanelState extends State<Panel> {
  final MapInteraction mapInteraction;
  GlobalKey<PlaceDisplayState> _placeDisplayKey = GlobalKey();
  PanelController controller = new PanelController();
  Widget child;

  _PanelState(this.mapInteraction) {
    child = SearchBox(mapInteraction);
  }

  @override
  void initState() {
    super.initState();
    this.mapInteraction.setPanelController(this.controller);
    this.mapInteraction.setPlaceDisplayKey(this._placeDisplayKey);
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      // Child must have at least 10 padding
      panel: Container(
          height: 30,
          padding: EdgeInsets.only(top: 25, left: 0, right: 0),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                children: [this.child, PlaceDisplay(key: _placeDisplayKey)],
                padding: EdgeInsets.all(0),
              ))),
      controller: this.controller,
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0), bottom: Radius.zero),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 16,
            blurRadius: 10)
      ],
      color: Color(0xff343332),
      header: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Container(
            width: 50,
            height: 6,
            margin: EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
                color: Color(0xff7E7E7E),
                borderRadius: BorderRadius.circular(5)),
          ))),
    );
  }
}
