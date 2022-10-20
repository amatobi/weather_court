import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/src/data/static/cities_data.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';
import 'package:weathercourt/src/ui/widgets/animations/tick_animation.dart';
import 'package:weathercourt/src/ui/widgets/shared/components.dart';

import '../../state_management/internet_connectivity/internet_connectivity_cubit.dart';
import '../widgets/shared/custom_page_route.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getIt = GetIt.instance;
  final lagos = cities.first;

  @override
  void initState() {
    getIt.get<InternetConnectionCubit>().checkConnection();

    getIt.get<WeatherBloc>().add(
          WeatherEvent.onFetch(
            lagos['city'],
            double.parse(lagos['lng']),
            double.parse(lagos['lat']),
          ),
        );
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(
            child: const HomeScreen(),
          ),
          (route) => false);
    });
    super.initState();
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
            image: AssetImage('assets/images/splash_background.jpg'),
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
