part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
  factory WeatherState.initial() => WeatherInitial();
  factory WeatherState.loading() => WeatherLoading();
  factory WeatherState.loaded(Weather weather) =>
      WeatherLoaded(weather: weather);

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final int errorCode;
  final String errorMessage;

  const WeatherError({required this.errorCode, required this.errorMessage});

  @override
  List<Object> get props => [errorCode];
}
