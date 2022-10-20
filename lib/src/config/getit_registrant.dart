import 'package:get_it/get_it.dart';
import 'package:weathercourt/helper/weather_helper.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';

import '../state_management/cubit/local_weather_cubit.dart';
import '../state_management/internet_connectivity/internet_connectivity_cubit.dart';
import '../viewmodel/weather_viewmodel.dart';

class GetItRegistrant {
  final getIt = GetIt.instance;
  final WeatherViewModel _viewModel;
  late WeatherBloc _weatherBloc;
  late InternetConnectionCubit _internetConnectionCubit;
  late LocalWeatherCubit _localWeatherCubit;


  final WeatherHelper weatherHelper;

  GetItRegistrant(this.weatherHelper, this._viewModel) {
    _weatherBloc = WeatherBloc(weatherHelper);
    _internetConnectionCubit = InternetConnectionCubit();
    _localWeatherCubit = LocalWeatherCubit(_viewModel);

    getIt.registerSingleton<WeatherBloc>(_weatherBloc);
    getIt.registerSingleton<LocalWeatherCubit>(_localWeatherCubit);

    getIt.registerSingleton<InternetConnectionCubit>(_internetConnectionCubit);
  }
}
