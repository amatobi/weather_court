import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/weather.dart';
import '../../services/weather_service/weather_service_contract.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  final IWeatherservice _weatherService;
  WeatherForecastCubit(this._weatherService) : super(WeatherForecastInitial());

  getForecast(String cityName) async {
    emit(WeatherForecastLoading());
    final weathers = await _weatherService.getForecast(cityName);
    emit(WeatherForecastSuccess(weathers));
  }
}
