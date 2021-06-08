import 'dart:developer';

import './Rating.dart';

abstract class Location {
  final String name;
  final PlaceLatLng coordinates;
  Location(this.name, this.coordinates);
}

class Place implements Location {
  final String name;
  final PlaceLatLng coordinates;
  int assistants;
  List<Rating> ratings = [
    new Rating("Calidad de la ventilación", 0),
    new Rating("Distanciamiento social", 0),
    new Rating("Facilidad del saneamiento de manos", 0),
    new Rating("Uso de mascarillas", 0),
    new Rating("Limpieza y desinfección del entorno", 0)
  ];
  double overalRatingAverage = 0;
  int numberOfRatings = 0;

  void setRatings(List<double> newRatings) {
    log(newRatings.toString());
    newRatings.asMap().forEach((index, rating) {
      this.ratings[index].rate = rating;
    });
  }

  Place(this.name, this.assistants, this.coordinates);
}

class PlaceLatLng {
  final double latitude;
  final double longitude;

  PlaceLatLng(this.latitude, this.longitude);
}

class UnregisteredPlace implements Location {
  final String name;
  final PlaceLatLng coordinates;
  UnregisteredPlace(this.name, this.coordinates);
}
