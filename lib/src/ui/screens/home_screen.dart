import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/src/state_management/cubit/local_weather_cubit.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getIt = GetIt.instance;
  late final  LocalWeatherCubit _localWeatherCubit;

  @override
  void initState() {
    _localWeatherCubit = getIt.get<LocalWeatherCubit>();
   _updateOnWeatherLoaded();
    super.initState();
  }

   void _updateOnWeatherLoaded() {
    getIt.get<WeatherBloc>().stream.listen((state) { 
      if(state is WeatherLoaded){
        _localWeatherCubit.viewModel.addWeather(state.weather);
        _localWeatherCubit.fetchLocalWeather();
      }
    });
   }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if(state is WeatherLoaded){
          print('THE WEATHER ${state.weather.description}');
        }
        return Container();
      },
    );
  }
  
 
}
