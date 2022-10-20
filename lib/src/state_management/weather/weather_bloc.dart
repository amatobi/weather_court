import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weathercourt/helper/weather_helper.dart';

import '../../models/weather.dart';
import '../../utils/errors.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherHelper weatherHelper;
  WeatherBloc(this.weatherHelper) : super(WeatherState.initial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      final Weather weather = await weatherHelper
          .getWeather(
        event.cityName,
        latitude: event.latitude,
        longitude: event.longitude,
      )
          .catchError((error) {
        if (error is HTTPException) {
          emit(
              WeatherError(errorCode: error.code, errorMessage: error.message));
        } else {
          emit(const WeatherError(
              errorCode: 500, errorMessage: 'Internal error'));
        }
      });
      emit(WeatherLoaded(weather: weather));
    });
  }
}
