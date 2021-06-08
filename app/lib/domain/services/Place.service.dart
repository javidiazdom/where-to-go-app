import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/repositories/Location.repository.dart';

class PlaceService {
  static Future<Place> getLocation(PlaceLatLng coordinates) async {
    try {
      return await LocationRepository.getLocation(coordinates);
    } on HttpException catch (e) {
      throw e;
    }
  }

  static Future<Place> indicateFirstAssistance(
      UnregisteredPlace unregisteredPlace) async {
    try {
      var place = await LocationRepository.addLocation(
          unregisteredPlace.coordinates, unregisteredPlace.name);
      return await LocationRepository.noteForAssistance(place);
    } on HttpException catch (e) {
      throw e;
    }
  }

  static Future<Place> registerPlace(
      UnregisteredPlace unregisteredPlace) async {
    try {
      return await LocationRepository.addLocation(
          unregisteredPlace.coordinates, unregisteredPlace.name);
    } on HttpException catch (e) {
      throw e;
    }
  }

  static Future<Place> noteForAssistance(Location place) async {
    try {
      return await LocationRepository.noteForAssistance(place);
    } on HttpException catch (e) {
      throw e;
    }
  }
}
