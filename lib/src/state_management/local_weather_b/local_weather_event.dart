part of 'local_weather_bloc.dart';

abstract class LocalWeatherEvent extends Equatable {
  const LocalWeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchLocalWeather extends LocalWeatherEvent {}

class AddLocalWeather extends LocalWeatherEvent {
  final Weather weather;
  const AddLocalWeather(this.weather);
  @override
  List<Object> get props => [weather];
}

class DeleteLocalWeather extends LocalWeatherEvent {
  final Weather weather;
  const DeleteLocalWeather(this.weather);
  @override
  List<Object> get props => [weather];
}

class RefreshLocalWeather extends LocalWeatherEvent {
  final Weather weather;

  const RefreshLocalWeather(this.weather);
  @override
  List<Object> get props => [weather];
}
