import 'package:get_it/get_it.dart';
import 'package:weathercourt/helper/weather_helper.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';

import '../state_management/internet_connectivity/internet_connectivity_cubit.dart';

class GetItRegistrant {
  final getIt = GetIt.instance;
  late WeatherBloc _weatherBloc;
  late InternetConnectionCubit _internetConnectionCubit;

  final WeatherHelper weatherHelper;

  GetItRegistrant(this.weatherHelper) {
    _weatherBloc = WeatherBloc(weatherHelper);
    _internetConnectionCubit = InternetConnectionCubit();

    getIt.registerSingleton<WeatherBloc>(_weatherBloc);
    getIt.registerSingleton<InternetConnectionCubit>(_internetConnectionCubit);
  }
}
