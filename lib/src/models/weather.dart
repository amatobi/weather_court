// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/converters.dart';
import '../utils/weather_icons.dart';

part 'weather.g.dart';

enum WeatherType {
  clearDay,
  clearNight,
  fewCloudsDay,
  fewCloudsNight,
  cloudsDay,
  cloudsNight,
  showerRainDay,
  showerRainNight,
  rainDay,
  rainNight,
  thunderStormDay,
  thunderStormNight,
  snowDay,
  snowNight,
  mistDay,
  mistNight,
}

@HiveType(typeId: 1)
class Weather extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? time;
  @HiveField(2)
  int? sunrise;
  @HiveField(3)
  int? sunset;
  @HiveField(4)
  int? humidity;
  @HiveField(5)
  String? description;
  @HiveField(6)
  String? iconCode;
  @HiveField(7)
  String? main;
  @HiveField(8)
  String? cityName;
  @HiveField(9)
  double? windSpeed;
  @HiveField(10)
  Temperature? temperature;
  @HiveField(11)
  Temperature? maxTemperature;
  @HiveField(12)
  Temperature? minTemperature;
  @HiveField(13)
  List<Weather>? forecast = [];

  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  factory Weather.empty() {
    return Weather();
  }

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <Weather>[];
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['main']['temp'],
          )),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  WeatherType getWeatherType() {
    switch (iconCode) {
      case '01d':
        return WeatherType.clearDay;
      case '01n':
        return WeatherType.clearNight;
      case '02d':
        return WeatherType.fewCloudsNight;
      case '02n':
        return WeatherType.fewCloudsDay;

      case '03d':
      case '04d':
        return WeatherType.cloudsDay;

      case '03n':
      case '04n':
        return WeatherType.cloudsNight;

      case '09d':
        return WeatherType.showerRainDay;

      case '09n':
        return WeatherType.showerRainNight;

      case '10d':
        return WeatherType.rainDay;

      case '10n':
        return WeatherType.rainNight;

      case '11d':
        return WeatherType.thunderStormDay;

      case '11n':
        return WeatherType.thunderStormNight;

      case '13d':
        return WeatherType.snowDay;

      case '13n':
        return WeatherType.snowNight;

      case '50d':
        return WeatherType.mistDay;

      case '50n':
        return WeatherType.mistNight;

      default:
        return WeatherType.clearDay;
    }
  }

  IconData getIconData() {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clearDay;
      case '01n':
        return WeatherIcons.clearNight;
      case '02d':
        return WeatherIcons.fewCloudsDay;
      case '02n':
        return WeatherIcons.fewCloudsDay;
      case '03d':
      case '04d':
        return WeatherIcons.cloudsDay;
      case '03n':
      case '04n':
        return WeatherIcons.clearNight;
      case '09d':
        return WeatherIcons.showerRainDay;
      case '09n':
        return WeatherIcons.showerRainNight;
      case '10d':
        return WeatherIcons.rainDay;
      case '10n':
        return WeatherIcons.rainNight;
      case '11d':
        return WeatherIcons.thunderStormDay;
      case '11n':
        return WeatherIcons.thunderStormNight;
      case '13d':
        return WeatherIcons.snowDay;
      case '13n':
        return WeatherIcons.snowNight;
      case '50d':
        return WeatherIcons.mistDay;
      case '50n':
        return WeatherIcons.mistNight;
      default:
        return WeatherIcons.clearDay;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'time': time,
      'sunrise': sunrise,
      'sunset': sunset,
      'humidity': humidity,
      'description': description,
      'iconCode': iconCode,
      'main': main,
      'cityName': cityName,
      'windSpeed': windSpeed,
      'temperature': temperature?.kelvin,
      'maxTemperature': maxTemperature?.kelvin,
      'minTemperature': minTemperature?.kelvin,
    };
  }

  static Weather fromHive(Map<String, dynamic> hive) {
    return Weather(
      id: hive['id'],
      time: hive['time'],
      sunrise: hive['sunrise'],
      sunset: hive['sunset'],
      humidity: hive['humidity'],
      description: hive['description'],
      iconCode: hive['iconCode'],
      main: hive['main'],
      cityName: hive['cityName'],
      windSpeed: hive['windSpeed'],
      temperature: Temperature(hive['temperature']),
      maxTemperature: Temperature(hive['maxTemperature']),
      minTemperature: Temperature(hive['minTemperature']),
      //forecast:  List<Weather>.from(hive['forecast']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          id == other.id &&
          cityName == other.cityName &&
          listEquals(forecast, other.forecast);

  @override
  int get hashCode => cityName.hashCode;
}
