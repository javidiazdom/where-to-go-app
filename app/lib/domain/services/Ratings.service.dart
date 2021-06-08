import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/repositories/Ratings.repository.dart';
import 'package:app/domain/services/Place.service.dart';

class RatingsService {
  static Future<bool> rateLocation(Location place, List<double> ratings) async {
    try {
      return await RatingsRepository.rateLocation(place, ratings);
    } on HttpException catch (e) {
      throw e;
    }
  }

  static Future<bool> registerLocationAndRateIt(
      UnregisteredPlace unRegisteredPlace, List<double> ratings) async {
    try {
      var place = await PlaceService.registerPlace(unRegisteredPlace);
      return await rateLocation(place, ratings);
    } on HttpException catch (e) {
      throw e;
    }
  }
}
