import 'dart:developer';

import 'package:app/domain/models/Place.dart';
import 'package:app/domain/services/Ratings.service.dart';
import 'package:flutter/material.dart';
import 'package:app/infraestructure/view/constants/RatingDescriptionData.dart';
import 'package:app/infraestructure/view/widgets/RatingDescription.dart';

class RatingPage extends StatelessWidget {
  Place place;
  RatingPage(this.place);

  List<double> ratings = [0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => {Navigator.of(context).pop(true)},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset("assets/Protected.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Añadir una valoración sobre ${this.place.name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: descriptions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RatingDescription(descriptions[index].name,
                          descriptions[index].description, (rating) {
                        this.ratings[index] = rating;
                      });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (await RatingsService.rateLocation(
                            place, this.ratings)) {
                          Navigator.of(context).pop(true);
                        }
                        ;
                      } catch (error) {
                        log(error.toString());
                      }
                    },
                    child: Text("Enviar valoraciones"),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith<Size>(
                            (states) => Size(1000.0, 40.0)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    Color(0xff21ABAB)))),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
