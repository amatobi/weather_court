part of 'local_weather_cubit.dart';

abstract class LocalWeatherState extends Equatable {
  const LocalWeatherState();

  @override
  List<Object> get props => [];
}

class LocalWeatherInitial extends LocalWeatherState {}
class LocalWeatherLoading extends LocalWeatherState {}
class LocalWeatherFetched extends LocalWeatherState {
  final List<Weather> weathers;
  const LocalWeatherFetched(this.weathers);

  @override
  List<Object> get props => [weathers];
}
