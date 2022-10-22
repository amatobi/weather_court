import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/state_management/local_weather_b/local_weather_bloc.dart';
import 'package:weathercourt/src/ui/widgets/shared/forecast_widget.dart';

import '../../helper/geolocator_helper.dart';
import '../../state_management/weather/weather_bloc.dart';
import '../../state_management/weather_forecast/weather_forecast_cubit.dart';
import 'list_of_cities.dart';
import '../widgets/shared/components.dart';
import '../widgets/shared/weather_widget.dart';
import '../../utils/constants.dart';
import '../../utils/time_utils.dart';

import '../../config/constants.dart';
import '../../models/weather.dart';
import '../widgets/shared/custom_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getIt = GetIt.instance;
  late final LocalWeatherBloc _localWeatherBloc;
  final pageController = PageController();
  Weather? selectedWeather;
  final weatherBox = Hive.box('weather');

  @override
  void initState() {
    _localWeatherBloc = getIt.get<LocalWeatherBloc>();
    _updateOnWeatherLoaded();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  void _updateOnWeatherLoaded() {
    getIt.get<WeatherBloc>().stream.listen((state) {
      if (state is WeatherLoaded) {
        _localWeatherBloc.add(AddLocalWeather(state.weather));
      } else if (state is WeatherError) {
        errorToast('Could not get weather, please try again later');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            timeOfDayBackgroundAsset(
              timeOfTheDay(),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.2),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      greeting(
                        timeOfTheDay(),
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Row(
                      children: [
                        glassIconButton(
                            radius: size.width * 0.02,
                            assetName: Constants.locationIcon,
                            iconHeight: size.width * 0.1,
                            width: size.width * 0.13,
                            onTap: () {
                              _fecchWeatherWithLocation();
                            }),
                        SizedBox(width: size.width * 0.02),
                        glassIconButton(
                            radius: size.width * 0.02,
                            assetName: Constants.addWeatherIcon,
                            iconHeight: size.width * 0.1,
                            width: size.width * 0.13,
                            onTap: () {
                              Navigator.push(
                                  context, CustomPageRoute(child: AllCities()));
                            }),
                      ],
                    ),
                    //Icon
                  ],
                ),
              ),
              BlocBuilder<LocalWeatherBloc, LocalWeatherState>(
                builder: (context, state) {
                  if (state is LocalWeatherFetched) {
                    final items = state.weathers;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: items.map((e) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              margin: const EdgeInsets.all(7),
                              width: size.width * 0.025,
                              height: size.width * 0.025,
                              decoration: BoxDecoration(
                                  color: e == selectedWeather
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(50)),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.52,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: items.length,
                            onPageChanged: (v) {
                              setState(() {
                                selectedWeather = items[v];
                              });
                              final internetState =
                                  getIt.get<InternetConnectionCubit>().state;
                              if (internetState is Connected) {
                                _localWeatherBloc
                                    .add(RefreshLocalWeather(items[v]));
                                getIt
                                    .get<WeatherForecastCubit>()
                                    .getForecast(items[v].cityName!);
                              }
                            },
                            itemBuilder: ((
                              context,
                              i,
                            ) {
                              selectedWeather = items[i];

                              return WeatherWidget(
                                weather: items[i],
                              );
                            }),
                          ),
                        ),
                        ForecastWidget()
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fecchWeatherWithLocation() async {
    try {
      final position = await GeoLocatorHelper.determinePosition();

      getIt.get<WeatherBloc>().add(
            FetchWeather(
              longitude: position.longitude,
              latitude: position.latitude,
            ),
          );
    } catch (e) {
      switch (e) {
        case GeoErrorType.disabled:
          locationDeniedDialog(
            context: context,
            message:
                '''Your Location sevices are currently disabled. Please turn them on in your device settings.''',
          );

          break;
        case GeoErrorType.deniedForever:
          locationDeniedDialog(
            context: context,
            message:
                'Location is denied ☹️, Please Go to  settings to enable them ',
          );

          break;
        default:
      }
    }
  }
}
