import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathercourt/src/helper/weather_helper.dart';
import 'package:weathercourt/material_init.dart';
import 'package:weathercourt/src/config/getit_registrant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/models/weather.dart';
import 'src/services/weather_service/weather_service_contract.dart';
import 'src/services/weather_service/weather_service_impl.dart';

import 'src/cache/local_cache_contract.dart';
import 'src/cache/local_cache_impl.dart';
import 'src/data/datasource/datasource_contract.dart';
import 'src/data/datasource/hive_datasource_impl.dart';
import 'src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'src/state_management/loading_location/loading_location_cubit.dart';
import 'src/state_management/local_weather/local_weather_bloc.dart';
import 'src/state_management/selected_item/selected_item_cubit.dart';
import 'src/state_management/temperature_unit/temperature_unit_cubit.dart';
import 'src/state_management/weather/weather_bloc.dart';
import 'src/utils/converters.dart';
import 'src/viewmodel/weather_viewmodel.dart';

class CompositionRoot {
  static late IWeatherservice _weatherservice;
  static late WeatherHelper _weatherHelper;
  static late WeatherViewModel _viewModel;
  static late IDatasource _datasource;
  static late SharedPreferences _pref;
  static late ILocalCache _localCache;

  static Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    _registerAdapters();
    _weatherservice = WeatherService();
    _weatherHelper = WeatherHelper(weatherservice: _weatherservice);
    // final directory = await getApplicationDocumentsDirectory();
    final box = await Hive.openBox<Weather>('weather');

    _pref = await SharedPreferences.getInstance();
    _datasource = HiveDatasource(box);
    _viewModel = WeatherViewModel(_datasource);
    _localCache = LocalCache(_pref);
    GetItRegistrant(
        _weatherHelper, _viewModel, _localCache, _pref, _weatherservice);
  }

  static Widget start() {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<WeatherBloc>()),
        BlocProvider.value(value: GetIt.I<LocalWeatherBloc>()),
        BlocProvider.value(value: GetIt.I<TemperatureUnitCubit>()),
        BlocProvider.value(value: GetIt.I<InternetConnectionCubit>()),
        BlocProvider.value(value: GetIt.I<SelectedItemCubit>()), 
        BlocProvider.value(value: GetIt.I<LoadingLocationCubit>())
      ],
      child: const MaterialInit(),
    );
  }
  
  static void _registerAdapters() {
    Hive
    ..registerAdapter(WeatherAdapter())
    ..registerAdapter(TemperatureAdapter())
    ..registerAdapter(TemperatureUnitAdapter());


  }
}
