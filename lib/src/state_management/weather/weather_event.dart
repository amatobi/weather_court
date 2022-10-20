part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  factory WeatherEvent.onFetch(
          String cityName, double longitude, double latitude) =>
      FetchWeather(
          cityName: cityName, longitude: longitude, latitude: latitude);
}

class FetchWeather extends WeatherEvent {
  final String cityName;
  final double longitude;
  final double latitude;

  const FetchWeather({
    required this.cityName,
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object> get props => [cityName, longitude, latitude];
}
