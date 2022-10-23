import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathercourt/src/helper/weather_helper.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';

import '../cache/local_cache_contract.dart';
import '../helper/onboard.dart';
import '../state_management/internet_connectivity/internet_connectivity_cubit.dart';
import '../state_management/loading_location/loading_location_cubit.dart';
import '../state_management/local_weather/local_weather_bloc.dart';
import '../state_management/selected_item/selected_item_cubit.dart';
import '../state_management/temperature_unit/temperature_unit_cubit.dart';
import '../viewmodel/weather_viewmodel.dart';

class GetItRegistrant {
  final getIt = GetIt.instance;
  final WeatherViewModel _viewModel;
  final ILocalCache _localCache;
  final WeatherHelper weatherHelper;
  final SharedPreferences _pref;
  final IWeatherservice _weatherService;

  late WeatherBloc _weatherBloc;
  late InternetConnectionCubit _internetConnectionCubit;
  late LocalWeatherBloc _localWeatherBloc;
  late TemperatureUnitCubit _temperatureUnitCubit;
  late SelectedItemCubit _selectedItemCubit;
  late LoadingLocationCubit _loadingLocation;

  late Onboard _onboard;

  GetItRegistrant(
      this.weatherHelper, this._viewModel, this._localCache, this._pref, this._weatherService) {
    _weatherBloc = WeatherBloc(weatherHelper);
    _internetConnectionCubit = InternetConnectionCubit();
    _localWeatherBloc = LocalWeatherBloc(_viewModel, weatherHelper);
    _temperatureUnitCubit = TemperatureUnitCubit(_localCache);
    _onboard = Onboard(_pref, _weatherService, _viewModel);
    _selectedItemCubit = SelectedItemCubit();
    _loadingLocation = LoadingLocationCubit();

    getIt.registerSingleton<WeatherBloc>(_weatherBloc);
    getIt.registerSingleton<Onboard>(_onboard);
    getIt.registerSingleton<LocalWeatherBloc>(_localWeatherBloc);
    getIt.registerSingleton<TemperatureUnitCubit>(_temperatureUnitCubit);
    getIt.registerSingleton<InternetConnectionCubit>(_internetConnectionCubit);
    getIt.registerSingleton<SelectedItemCubit>(_selectedItemCubit);
    getIt.registerSingleton<LoadingLocationCubit>(_loadingLocation);


  }
}
