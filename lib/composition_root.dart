import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weathercourt/helper/weather_helper.dart';
import 'package:weathercourt/material_init.dart';
import 'package:weathercourt/src/config/getit_registrant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_impl.dart';

import 'src/data/datasource/datasource_contract.dart';
import 'src/data/datasource/hive_datasource_impl.dart';
import 'src/state_management/cubit/local_weather_cubit.dart';
import 'src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'src/state_management/weather/weather_bloc.dart';
import 'src/viewmodel/weather_viewmodel.dart';

class CompositionRoot {
  static late IWeatherservice _weatherservice;
  static late WeatherHelper _weatherHelper;
  static late WeatherViewModel _viewModel;
  static late IDatasource _datasource;

  static Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    _weatherservice = WeatherService();
    _weatherHelper = WeatherHelper(weatherservice: _weatherservice);
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open('collections', {'weather'},
        path: directory.path);
    _datasource = HiveDatasource(collection);
    _viewModel = WeatherViewModel(_datasource);
    GetItRegistrant(_weatherHelper, _viewModel);
  }

  static Widget start() {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<WeatherBloc>()),
        BlocProvider.value(value: GetIt.I<LocalWeatherCubit>()),
        BlocProvider.value(value: GetIt.I<InternetConnectionCubit>()),
      ],
      child: const MaterialInit(),
    );
  }
}
