import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weathercourt/src/viewmodel/weather_viewmodel.dart';

import '../../models/weather.dart';

part 'local_weather_state.dart';

class LocalWeatherCubit extends Cubit<LocalWeatherState> {
  final WeatherViewModel viewModel;
  LocalWeatherCubit(this.viewModel) : super(LocalWeatherInitial());

  fetchLocalWeather()async {
    emit(LocalWeatherLoading());
    final weather = await viewModel.fetchWeather();


    emit(LocalWeatherFetched(weather));
  }
}
