import '../data/datasource/datasource_contract.dart';
import '../models/weather.dart';

class WeatherViewModel {
  final IDatasource _datasource;

  WeatherViewModel(this._datasource);

  Future<void> addWeather(Weather weather) async {
    if (!await _constraintView()) {
      _datasource.addWeatherData(weather);
    }
  }
  Future<void> updateWeather(Weather weather) async {
    _datasource.updateWeatherData(weather);
  }
  Future<void> removeWeather(Weather weather)async{
    _datasource.deleteSingleWeatherData(weather);

  }

  Future<bool> _constraintView() async {
    final data = await _datasource.fetchWeatherData();
    int length = data.length;
    return length == 15;
  }

  // Future<bool> _isExistingWeather(int weatherId) async {
  //   return await _datasource.findSingleWeatherData(weatherId) != null;
  // }

  Future<List<Weather>> fetchWeather() async {
    final localWeathers = await _datasource.fetchWeatherData();
    return localWeathers;
  }

  Future<Weather?> findSingleWeatherData(Weather weather) async {
    return await _datasource.findSingleWeatherData(weather);
  }
}
