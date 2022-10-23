import 'package:weathercourt/src/ui/widgets/shared/components.dart';

import '../data/datasource/datasource_contract.dart';
import '../models/weather.dart';

class WeatherViewModel {
  final IDatasource _datasource;

  WeatherViewModel(this._datasource);

  Future<void> addWeather(Weather weather) async {
    if (!await _constraintView()) {     
      if (!await _isExistingWeather(weather)) {
        _datasource.addWeatherData(weather);
      } else {
        messageToast('Updating ${weather.cityName}');
      }
    }
  }

  Future<void> addMultipleWeather(List<Weather> weathers) async {
    _datasource.addMultipleWeatherData(weathers);
  }

  Future<void> updateWeather(Weather weather) async {
    _datasource.updateWeatherData(weather);
  }

  Future<void> removeWeather(Weather weather) async {
    //if(_isDefaultCity(weather))return;
    _datasource.deleteSingleWeatherData(weather);
  }

  Future<bool> _constraintView() async {
    final data = await _datasource.fetchWeatherData();
    int length = data.length;
    return length == 15;
  }

  Future<bool> _isExistingWeather(Weather weather) async {
    return await _datasource.findSingleWeatherData(weather) != null;
  }

  // bool _isDefaultCity(Weather weather) {
  //   return weather.cityName!.contains('lagos');
  // }

  Future<List<Weather>> fetchWeather() async {
    final localWeathers = await _datasource.fetchWeatherData();
    return localWeathers;
  }

  Future<Weather?> findSingleWeatherData(Weather weather) async {
    return await _datasource.findSingleWeatherData(weather);
  }
}
