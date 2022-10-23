import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathercourt/src/config/constants.dart';
import 'package:weathercourt/src/models/weather.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';

import '../models/city.dart';
import '../services/weather_service/weather_service_contract.dart';
import '../viewmodel/weather_viewmodel.dart';
import 'city_helper.dart';

class Onboard {
  final SharedPreferences pref;
  final IWeatherservice weatherService;
  final WeatherViewModel viewModel;
  final getIt = GetIt.I;

  Onboard(this.pref, this.weatherService, this.viewModel);

  bool isNewUser() => pref.getBool(Constants.prefKeyIsNew) ?? true;

  Future<void> setup(Function(bool) callback) async {
    List<Weather> weathers = [];

    final state = getIt.get<InternetConnectionCubit>().state;
    if (state is Connected) {
      for (City city in CityHelper.defaultCities()) {
        final weather = await weatherService.getWeatherData(city.cityName!);
        weathers.add(weather);
      }
      viewModel.addMultipleWeather(weathers).then((value) {});
      pref.setBool(Constants.prefKeyIsNew, false);
      callback(true);
    } else {
      callback(false);
    }
  }
}
