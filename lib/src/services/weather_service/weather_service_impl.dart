import 'dart:convert';

import 'package:weathercourt/src/config/api_key.dart';
import 'package:weathercourt/src/config/constants.dart';
import 'package:weathercourt/src/models/weather.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';
import 'package:http/http.dart' as http;

import '../../utils/errors.dart';

class WeatherService implements IWeatherservice {
  final apiKey = ApiKeys.openWeatherMap;
  final host = Constants.openWeatherMapBaseApi;
  @override
  Future<String> getCityNameFromLocation(
      {required double latitude, required double longitude}) async {
    Uri uri = Uri.parse(
        '$host/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final weatherJson = json.decode(response.body);
      return weatherJson['name'];
    } else {
      throw HTTPException(response.statusCode, "Failed to get city name");
    }
  }

  @override
  Future<Weather> getWeatherData(String cityName) async {
    Uri uri = Uri.parse('$host/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "Failed to get weather data");
      
    }

    final weatherJson = json.decode(response.body);
    return Weather.fromJson(weatherJson);
  }

  @override
  Future<List<Weather>> getForecast(String cityName) async {
    Uri uri = Uri.parse('$host/data/2.5/forecast?q=$cityName&appid=$apiKey');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch forcast data");
    }

    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
