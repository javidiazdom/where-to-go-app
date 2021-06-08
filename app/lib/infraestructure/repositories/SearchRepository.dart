import 'dart:convert';
import 'dart:developer';

import 'package:app/infraestructure/http/HttpException.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:app/infraestructure/view/constants/MapboxConfig.dart';

class SearchResponse {
  LatLng coordinates;
  String placeName;
  SearchResponse(this.coordinates, this.placeName);
}

class SearchRepository {
  static Future<SearchResponse> searchPlace(
      String search, LatLng proximityBias) async {
    Uri queryString = Uri.parse(
        'http://api.mapbox.com/geocoding/v5/mapbox.places/${search}.json?access_token=${accessToken}&autocomplete=false&types=poi&bbox=-18.57010488770959%2C27.173224472781968%2C-13.266790700166126%2C29.613521629527966&proximity=${proximityBias.latitude},${proximityBias.longitude}');
    var response = await http.get(queryString);
    if (response.statusCode != 200) {
      throw new HttpException(
          "No se puede establecer la conexión en este momento");
    } else {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['features'].length > 0 &&
          decodedResponse['features'][0]['geometry'] != null) {
        return new SearchResponse(
            new LatLng(
                decodedResponse['features'][0]['geometry']['coordinates'][1]
                    .toDouble(),
                decodedResponse['features'][0]['geometry']['coordinates'][0]
                    .toDouble()),
            decodedResponse['features'][0]['text']);
      } else {
        throw new HttpException("No se ha encontrado el lugar");
      }
    }
  }
}
