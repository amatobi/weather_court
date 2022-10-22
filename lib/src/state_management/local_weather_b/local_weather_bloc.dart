import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../helper/weather_helper.dart';
import '../../models/weather.dart';
import '../../viewmodel/weather_viewmodel.dart';

part 'local_weather_event.dart';
part 'local_weather_state.dart';

class LocalWeatherBloc extends Bloc<LocalWeatherEvent, LocalWeatherState> {
  final WeatherViewModel viewModel;
  final WeatherHelper _helper;
  LocalWeatherBloc(this.viewModel, this._helper)
      : super(LocalWeatherInitial()) {
    on<FetchLocalWeather>((event, emit) async {
      final weathers = await viewModel.fetchWeather();
      emit(LocalWeatherFetched(weathers));
    });

    on<AddLocalWeather>((event, emit) async {
      await viewModel.addWeather(event.weather);
      add(FetchLocalWeather());
    });

    on<DeleteLocalWeather>((event, emit) async {
      await viewModel.removeWeather(event.weather);
      add(FetchLocalWeather());
    });

    on<RefreshLocalWeather>((event, emit) async {
      final weather = await _helper.getWeather(event.weather.cityName);
      await viewModel.updateWeather(weather);
      add(FetchLocalWeather());
    });
  }
}
