import 'package:flutter/material.dart';
import 'package:app/domain/models/Place.dart';
import 'dart:developer';

class PlaceDisplay extends StatefulWidget {
  PlaceDisplay({Key key}) : super(key: key);

  @override
  PlaceDisplayState createState() => PlaceDisplayState();
}

class PlaceDisplayState extends State<PlaceDisplay> {
  Place _place = new Place("");

  void setPlace(Place place) {
    setState(() {
      this._place = place;
    });
  }

  Color getColor() {
    if (_place.assistants < 20) return Color(0xFF52FF00);
    if (_place.assistants < 100) return Color(0xFFFFE600);
    return Color(0xFFFF0000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 35),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _place.name,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                _place.assistants.toString(),
                style: TextStyle(
                    color: getColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Icon(
                Icons.person,
                color: getColor(),
                size: 20,
              ),
              Text("posibles asistentes",
                  style: TextStyle(color: Color(0xff7D7D7D), fontSize: 17))
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => {},
              child: Text("Indicar asistencia"),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith<Size>(
                      (states) => Size(1000.0, 40.0)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => Color(0xff21ABAB)))),
          SizedBox(height: 20),
          Text(
            "Valoraciones de otros usuarios",
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Color(0xffFFC700),
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                this._place.overalRatingAverage.toString(),
                style: TextStyle(
                    color: Color(0xffFFC700), fontWeight: FontWeight.bold),
              ),
              Text("  (${this._place.numberOfRatings})"),
            ],
          ),
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.black,
            child: ListView.builder(
                itemCount: this._place.ratings.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  log(this._place.ratings[index].name);
                  return new Text(this._place.ratings[index].name);
                }),
          )
        ])));
  }
}
