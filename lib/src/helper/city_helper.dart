import 'package:weathercourt/src/data/static/cities_data.dart';
import 'package:weathercourt/src/models/city.dart';

class CityHelper {
  static List<City> citiesModeled() {
    return cities.map((e) => City.fromMap(e)).toList();
  }

  static List<City> defaultCities() {
    
    final lagos = citiesModeled()[0];
    final abuja = citiesModeled()[5];
    final ibadan = citiesModeled()[2];

    return [
      lagos,
      abuja,
      ibadan,
    ];
  }
}
