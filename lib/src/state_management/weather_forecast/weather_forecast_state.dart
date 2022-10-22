part of 'weather_forecast_cubit.dart';

abstract class WeatherForecastState extends Equatable {
  const WeatherForecastState();

  @override
  List<Object> get props => [];
}

class WeatherForecastInitial extends WeatherForecastState {}
class WeatherForecastLoading extends WeatherForecastState {}

class WeatherForecastSuccess extends WeatherForecastState {
  final List<Weather> weathers;
const WeatherForecastSuccess(this.weathers);
    @override
  List<Object> get props => [];
}

