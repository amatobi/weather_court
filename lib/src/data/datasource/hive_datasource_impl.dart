

import 'package:hive_flutter/hive_flutter.dart';
import 'package:weathercourt/src/data/datasource/datasource_contract.dart';
import 'package:weathercourt/src/models/weather.dart';

class HiveDatasource implements IDatasource {
  final BoxCollection collection;
  const HiveDatasource(this.collection);
  @override
  Future addWeatherData(Weather weather) async {
    final weatherBox = await collection.openBox('weather');
    weatherBox.put(weather.id.toString(), weather.toMap());
  }

  @override
  Future<List<Weather>> fetchWeatherData() async {
    final weatherBox = await collection.openBox('weather');

    final values = await weatherBox.getAllValues();

    final result = values.values.toList();

    final output = result.map((e) => Weather.fromJson(e)).toList();
    return output;
  }

  @override
  Future<Weather?> findSingleWeatherData(int weatherId) async {
    final weatherBox = await collection.openBox('weather');
    final item = await weatherBox.get(weatherId.toString());
    // final output = jsonEncode(item);

    if (item == null) return null;

    return Weather.fromJson(item);
  }
}
