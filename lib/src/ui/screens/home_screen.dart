import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/state_management/local_weather/local_weather_bloc.dart';
import 'package:weathercourt/src/theme/colors.dart';
import 'package:weathercourt/src/ui/widgets/shared/forecast_widget.dart';
import 'package:weathercourt/src/ui/widgets/shared/glass_morphism.dart';

import '../../helper/geolocator_helper.dart';
import '../../state_management/loading_location/loading_location_cubit.dart';
import '../../state_management/selected_item/selected_item_cubit.dart';
import '../../state_management/weather/weather_bloc.dart';
import 'list_of_cities.dart';
import '../widgets/shared/components.dart';
import '../widgets/shared/weather_widget.dart';
import '../../utils/constants.dart';
import '../../utils/time_utils.dart';

import '../../config/constants.dart';
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
  int selectedWeather = 1;

  @override
  void initState() {
    _localWeatherBloc = getIt.get<LocalWeatherBloc>()..add(FetchLocalWeather());
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
        navigate(const HomeScreen());
      } else if (state is WeatherError) {
        errorToast('Could not get weather, please try again later');
      } else if (state is WeatherLoading) {
        loadingDialog(context: context);
      }
    });
     _updateOnLocalWeather();
  }

  _updateOnLocalWeather() {
    final state = _localWeatherBloc.state;
    if (state is LocalWeatherFetched) {
      _localWeatherBloc.add(RefreshLocalWeather(state.weathers.last));
    }
  }

  navigate(Widget child) {
    Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(
          child: child,
        ),
        (route) => false);
  }

  _fetchWeatherWithLocation() async {
    try {
      getIt.get<LoadingLocationCubit>().isLoading(true);
      final position = await GeoLocatorHelper.determinePosition();
      getIt.get<LoadingLocationCubit>().isLoading(false);

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
                    Row(
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
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Icon(
                          greetingIcon(
                            timeOfTheDay(),
                          ),
                          color: white,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        BlocBuilder<LoadingLocationCubit, bool>(
                          builder: (context, isLoading) {
                            return glassIconButton(
                              radius: size.width * 0.02,
                              assetName: Constants.locationIcon,
                              iconHeight: size.width * 0.1,
                              width: size.width * 0.13,
                              onTap: isLoading
                                  ? null
                                  : () {
                                      confirmationDialog(
                                        context: context,
                                        message:
                                            'Your current location will be fetched, and updated to your watch list?',
                                        onConfirm: () {
                                          _fetchWeatherWithLocation();
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: white, strokeWidth: 2)
                                    : SvgPicture.asset(
                                        Constants.locationIcon,
                                        height: size.width * 0.1,
                                        color: white,
                                      ),
                              ),
                            );
                          },
                        ),
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
                    final items = state.weathers.reversed.toList();
                    if (items.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.width * 0.8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: AllCities(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: size.width * 0.45,
                                height: size.width * 0.15,
                                child: const GlassMorphism(
                                  blur: 2,
                                  opacity: 0.3,
                                  radius: 15,
                                  child: Center(
                                    child: Text(
                                      'Add city',
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: items.map((e) {
                            return BlocBuilder<SelectedItemCubit, int>(
                              builder: (context, state) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 600),
                                  margin: const EdgeInsets.all(7),
                                  width: size.width * 0.025,
                                  height: size.width * 0.025,
                                  decoration: BoxDecoration(
                                      color: e.key == state
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(50)),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.77,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.27,
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Text("Forecast",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 19,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              PageView.builder(
                                controller: pageController,
                                itemCount: items.length,
                                onPageChanged: (v) {
                                  getIt
                                      .get<SelectedItemCubit>()
                                      .selectItem(items[v].key);

                                  final internetState = getIt
                                      .get<InternetConnectionCubit>()
                                      .state;
                                  if (internetState is Connected) {
                                    _localWeatherBloc
                                        .add(RefreshLocalWeather(items[v]));
                                    // getIt
                                    //     .get<WeatherForecastCubit>()
                                    //     .getForecast(items[v].cityName!);
                                  }
                                },
                                itemBuilder: ((
                                  context,
                                  i,
                                ) {
                                  getIt
                                      .get<SelectedItemCubit>()
                                      .selectItem(items[i].key);

                                  return Column(
                                    children: [
                                      WeatherWidget(
                                        weather: items[i],
                                      ),
                                      items[i].forecast != null
                                          ? ForecastWidget(
                                              weathers: items[i].forecast!,
                                            )
                                          : Column(
                                              children: [
                                                SizedBox(
                                                    height: size.width * 0.3),
                                                circularProgress(
                                                    size.width * 0.06, 2),
                                              ],
                                            )
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
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
}
