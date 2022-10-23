
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weathercourt/src/data/datasource/datasource_contract.dart';
import 'package:weathercourt/src/models/weather.dart';

class HiveDatasource implements IDatasource {  
  final Box<Weather> _box;
  const HiveDatasource( this._box);
  @override
  Future<void> addWeatherData(Weather weather) async {
    await _box.add(weather);
   
  }

@override
  Future<void> addMultipleWeatherData(List<Weather> weathers)async {
    await _box.addAll(weathers);
   
  }

  @override
  Future<void> updateWeatherData(Weather weather) async {
    final boxtoEdit =
        _box.values.firstWhere((element) => element.cityName == weather.cityName);
    final index = boxtoEdit.key;
  
   
    _box.put(index, weather);
  }

  @override
  Future<List<Weather>> fetchWeatherData() async {
    final result = _box.values.toList();
    

    return result;
  }

  @override
  Future<Weather?> findSingleWeatherData(Weather weather) async {
    final item = _box.values.where((element) => element.cityName == weather.cityName);

    if (item.isEmpty) return null;

    return item.first;
  }

  @override
  Future<void> deleteSingleWeatherData(Weather weather) async {
    _box.delete(weather.key);
  }
  
  
}
