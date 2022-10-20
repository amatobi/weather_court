import '../../models/weather.dart';

abstract class IWeatherservice {
  Future<String> getCityNameFromLocation({
    required double latitude,
    required double longitude,
  });

  Future<Weather> getWeatherData(String cityName);
    Future<List<Weather>> getForecast(String cityName);
}
