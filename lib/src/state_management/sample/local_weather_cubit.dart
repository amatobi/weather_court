// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:weathercourt/src/viewmodel/weather_viewmodel.dart';

// import '../../helper/weather_helper.dart';
// import '../../models/weather.dart';

// part 'local_weather_state.dart';

// class LocalWeatherCubit extends Cubit<LocalWeatherState> {
//   final WeatherViewModel viewModel;
//   final WeatherHelper _helper;
//   LocalWeatherCubit(this.viewModel, this._helper)
//       : super(LocalWeatherInitial());

//   fetchLocalWeather() async {
//     emit(LocalWeatherLoading());
//     final weather = await viewModel.fetchWeather();

//     emit(LocalWeatherFetched(weather));
//   }

//   refreshLocalWeather() async {
//     emit(LocalWeatherLoading());
   

  
//   }

//   // _fetchWeather() {
//   //   Future.delayed(const Duration(seconds: 2), () async {
//   //     final weather = await viewModel.fetchWeather();
//   //     emit(LocalWeatherFetched(weather));
//   //   });
//   // }

//   deleteLocalWeather(int weatherId) async {
//     emit(LocalWeatherLoading());
//     viewModel.removeWeather(weatherId);
//   }
// }
