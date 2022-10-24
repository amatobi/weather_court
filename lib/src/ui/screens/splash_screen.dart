import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/src/state_management/local_weather/local_weather_bloc.dart';
import '../../config/constants.dart';

import '../../helper/onboard.dart';
import '../../state_management/internet_connectivity/internet_connectivity_cubit.dart';
import '../../state_management/temperature_unit/temperature_unit_cubit.dart';
import '../widgets/animations/tick_animation.dart';
import '../widgets/shared/components.dart';
import '../widgets/shared/custom_page_route.dart';
import 'home_screen.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getIt = GetIt.instance;
  late LocalWeatherBloc _localWeatherBloc;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  initialize() async {
    getIt.get<InternetConnectionCubit>().checkConnection();
    _localWeatherBloc = getIt.get<LocalWeatherBloc>();

    Future.delayed(const Duration(seconds: 5), () {
      if (getIt.get<Onboard>().isNewUser()) {
        navigate(const Onboarding());
      } else {
        navigate(const HomeScreen());
        getIt.get<TemperatureUnitCubit>().getTemperatureUnit();

        _localWeatherBloc.add(FetchLocalWeather());
         
      }
    });
  }

  

  navigate(Widget child) {
    Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(
          child: child,
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size, padding = media.padding;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        padding: padding..top,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Constants.splashBackground),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(height: size.width * 0.4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo(size),
                ],
              ),
              SizedBox(height: size.width * 0.1),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  TicAnimation(
                    isAnimating: true,
                    child: Image.asset('assets/icons/sun.png',
                        height: size.width * 0.3),
                  ),
                  Positioned(
                    right: size.width * 0.03,
                    bottom: 0,
                    child: Image.asset('assets/icons/blue_cloud.png'),
                  ),
                  Positioned(
                    right: size.width * 0.06,
                    top: size.width * 0.13,
                    child: Image.asset('assets/icons/white_cloud.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
