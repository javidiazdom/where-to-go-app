import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/infraestructure/view/widgets/SearchBox.dart';

class Panel extends StatefulWidget {
  const Panel();

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  Widget child = SearchBox();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      // Child must have at least 10 padding
      panel: Container(
          padding: EdgeInsets.only(top: 25, left: 15, right: 15),
          child: this.child),
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
