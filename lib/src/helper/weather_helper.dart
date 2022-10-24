import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';

import '../models/weather.dart';
import '../ui/widgets/shared/components.dart';

class WeatherHelper {
  final IWeatherservice weatherservice;
  WeatherHelper({required this.weatherservice});

  Future<Weather> getWeather(String? cityName,
      {double? latitude, double? longitude}) async {
       
        
    try {
      cityName ??= await weatherservice.getCityNameFromLocation(
          latitude: latitude!, longitude: longitude!);
      Weather weather = await weatherservice.getWeatherData(cityName);
      List<Weather> weathers = await weatherservice.getForecast(cityName);
      List<Weather> tempList = [...weathers];
      weather.forecast = tempList;
      return weather;
    } catch (e) {
      errorToast('Failed to get weather');
      rethrow;
    }
  }
}
