import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathercourt/src/config/constants.dart';


import '../models/city.dart';
import '../state_management/weather/weather_bloc.dart';
import 'city_helper.dart';

class Onboard {
  final SharedPreferences pref;
   final getIt = GetIt.I;

  Onboard( this.pref);

   setup() {
    print('SETUP CALLED 1');
    if (pref.getBool(Constants.prefKeyIsNew) ?? true) {
        print('SETUP CALLED 2');
      for (City city in CityHelper.defaultCities()) {
        getIt.get<WeatherBloc>().add(
              WeatherEvent.onFetch(
                city.cityName!,
                double.parse(city.longitude!),
                double.parse(city.latitude!),
              ),
            );
      }
      pref.setBool(Constants.prefKeyIsNew, false);
    }
  }
}
