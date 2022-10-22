import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:weathercourt/src/data/datasource/datasource_contract.dart';
import 'package:weathercourt/src/models/weather.dart';

class HiveDatasource implements IDatasource {  
  final Box<Weather> _box;
  const HiveDatasource( this._box);
  @override
  Future addWeatherData(Weather weather) async {
    _box.put(weather.id.toString(), weather);
  }
  @override
  Future<void> updateWeatherData(Weather weather) async {
    final boxtoEdit =
        _box.values.firstWhere((element) => element.id == weather.id);
    final index = boxtoEdit.key;
    _box.putAt(index, weather);
  }

  @override
  Future<List<Weather>> fetchWeatherData() async {
    final result = _box.values.toList();

    return result;
  }

  @override
  Future<Weather?> findSingleWeatherData(Weather weather) async {
    final item = _box.get(weather.key);

    if (item == null) return null;

    return item;
  }

  @override
  Future<void> deleteSingleWeatherData(Weather weather) async {
    _box.delete(weather.key);
  }
}
