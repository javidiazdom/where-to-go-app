import 'dart:convert';
import 'dart:developer';
import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/http/HttpGraphqlService.dart';
import 'package:app/infraestructure/http/mutations/Mutations.dart';
import '../http/queries/Place.queries.dart';
import 'dart:async';

class LocationRepository {
  static Future<Place> getLocation(PlaceLatLng coordinates) async {
    var response = await HttpGraphqlService.query(placeQuery,
        variables: jsonEncode({
          "latlng": [coordinates.latitude, coordinates.longitude],
        }),
        requireAuth: true);

    if (response.statusCode != 200) {
      throw new HttpException(
          "No se puede establecer la conexión en este momento");
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new HttpException(decodedResponse['errors'][0]['message']);
    } else {
      return new Place(
          decodedResponse['data']['location']['name'],
          decodedResponse['data']['location']['predictedAssistance'],
          new PlaceLatLng(
              decodedResponse['data']['location']['geoLocation']['coordinates']
                  [1],
              decodedResponse['data']['location']['geoLocation']['coordinates']
                  [0]));
    }
  }

  static Future<Place> addLocation(PlaceLatLng coordinates, String name) async {
    var response = await HttpGraphqlService.mutate(
        addPlaceMutation,
        jsonEncode({
          "name": name,
          "coordinates": [coordinates.latitude, coordinates.longitude]
        }),
        requireAuth: true);
    if (response.statusCode != 200) {
      throw new HttpException(
          "No se puede establecer la conexión en este momento");
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new HttpException(decodedResponse['errors'][0]['message']);
    } else {
      return new Place(
          decodedResponse['data']['addLocation']['name'],
          decodedResponse['data']['addLocation']['predictedAssistance'],
          new PlaceLatLng(
              decodedResponse['data']['addLocation']['geoLocation']
                  ['coordinates'][1],
              decodedResponse['data']['addLocation']['geoLocation']
                  ['coordinates'][0]));
    }
  }

  static Future<Place> noteForAssistance(Place place) async {
    var response = await HttpGraphqlService.mutate(
        noteForAssistanceMutation,
        jsonEncode({
          "name": place.name,
          "coordinates": [
            place.coordinates.longitude,
            place.coordinates.latitude
          ]
        }),
        requireAuth: true);
    if (response.statusCode != 200) {
      throw new HttpException(
          "No se puede establecer la conexión en este momento");
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new HttpException(decodedResponse['errors'][0]['message']);
    } else {
      return new Place(
          decodedResponse['data']['noteForAssistance']['name'],
          decodedResponse['data']['noteForAssistance']['predictedAssistance'],
          new PlaceLatLng(
              decodedResponse['data']['noteForAssistance']['geoLocation']
                  ['coordinates'][1],
              decodedResponse['data']['noteForAssistance']['geoLocation']
                  ['coordinates'][0]));
    }
  }
}
