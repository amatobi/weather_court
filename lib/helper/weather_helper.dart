import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';

import '../src/models/weather.dart';

class WeatherHelper {
  final IWeatherservice weatherservice;
  WeatherHelper({required this.weatherservice});

  Future<Weather> getWeather(String? cityName,
      {required double latitude, required double longitude}) async {
    cityName ??= await weatherservice.getCityNameFromLocation(
        latitude: latitude, longitude: longitude);
    Weather weather = await weatherservice.getWeatherData(cityName);
    List<Weather> weathers = await weatherservice.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}
