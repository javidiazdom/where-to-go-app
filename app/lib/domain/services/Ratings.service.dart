import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/repositories/Ratings.repository.dart';

class RatingsService {
  static Future<bool> rateLocation(Place place, List<double> ratings) async {
    try {
      return await RatingsRepository.rateLocation(place, ratings);
    } on HttpException catch (e) {
      throw e;
    }
  }
}
