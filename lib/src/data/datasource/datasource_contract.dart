import '../../models/weather.dart';

abstract class IDatasource {

  Future addWeatherData(Weather weather);
  Future<List<Weather>> fetchWeatherData();

  Future<Weather?> findSingleWeatherData(int weatherId);
}