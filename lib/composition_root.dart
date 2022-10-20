import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/helper/weather_helper.dart';
import 'package:weathercourt/material_init.dart';
import 'package:weathercourt/src/config/getit_registrant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_contract.dart';
import 'package:weathercourt/src/services/weather_service/weather_service_impl.dart';

import 'src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'src/state_management/weather/weather_bloc.dart';

class CompositionRoot {
  static late IWeatherservice _weatherservice;
  static late WeatherHelper _weatherHelper;

  static Future<void> configure() async {
    _weatherservice = WeatherService();
    _weatherHelper = WeatherHelper(weatherservice: _weatherservice);
    GetItRegistrant(_weatherHelper);
  }

  static Widget start() {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<WeatherBloc>()),
        BlocProvider.value(value: GetIt.I<InternetConnectionCubit>()),
      ],
      child: const MaterialInit(),
    );
  }
}
