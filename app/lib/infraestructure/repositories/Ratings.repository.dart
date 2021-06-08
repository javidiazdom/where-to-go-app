import 'dart:convert';
import 'dart:developer';
import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/DTOs/RatingsDTO.dart';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/http/HttpGraphqlService.dart';
import 'package:app/infraestructure/http/queries/Ratings.queries.dart';
import 'package:app/infraestructure/http/mutations/Mutations.dart';

class RatingsRepository {
  static Future<LocationRatingsDTO> getLocationRatings(Place place) async {
    var response = await HttpGraphqlService.query(getLocationRatingsQuery,
        variables: jsonEncode({
          "name": place.name,
          "coordinates": [
            place.coordinates.longitude,
            place.coordinates.latitude
          ]
        }),
        requireAuth: true);
    if (response.statusCode != 200) {
      throw HttpException(
          "No se ha podido establecer la conexión con el servidor");
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new HttpException(decodedResponse['errors'][0]['message']);
    } else {
      List<double> averages = [];
      decodedResponse['data']['locationRatings']['averages']
          .forEach((element) => {averages.add(element.toDouble())});
      log(averages.toString());

      return new LocationRatingsDTO(
          decodedResponse['data']['locationRatings']['mainAverage'].toDouble(),
          decodedResponse['data']['locationRatings']['averagesCount'],
          averages);
    }
  }

  static Future<bool> rateLocation(Location place, List<double> ratings) async {
    var response = await HttpGraphqlService.mutate(
        rateLocationMutation,
        jsonEncode({
          "name": place.name,
          "coordinates": [
            place.coordinates.longitude,
            place.coordinates.latitude
          ],
          "ratings": ratings
        }),
        requireAuth: true);
    if (response.statusCode != 200) {
      log(response.reasonPhrase.toString());
      throw HttpException(
          "No se ha podido establecer la conexión con el servidor");
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new HttpException(decodedResponse['errors'][0]['message']);
    } else {
      if (!decodedResponse['data']['rateLocation']['status']) {
        throw new HttpException(
            decodedResponse['data']['rateLocation']['message']);
      }
      return decodedResponse['data']['rateLocation']['status'];
    }
  }
}
