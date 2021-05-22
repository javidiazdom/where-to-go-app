import './Rating.dart';

class Place {
  final String name;
  int assistants = 3;
  List<Rating> ratings = [
    new Rating("Calidad de la ventilación", 4.5),
    new Rating("Distanciamiento social", 4.5),
    new Rating("Facilidad del saneamiento de manos", 4.5),
    new Rating("Uso de mascarillas", 4.5),
    new Rating("Limpieza y desinfección del entorno", 4.5)
  ];
  double overalRatingAverage = 3.6;
  int numberOfRatings = 342;

  Place(this.name);

  void addRating(Rating rating) {
    this.ratings.add(rating);
  }
}
