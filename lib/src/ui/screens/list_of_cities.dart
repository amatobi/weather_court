import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:weathercourt/src/config/constants.dart';
import 'package:weathercourt/src/state_management/weather/weather_bloc.dart';
import 'package:weathercourt/src/ui/widgets/shared/components.dart';
import '../../helper/city_helper.dart';
import '../../state_management/local_weather/local_weather_bloc.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';
import '../../utils/time_utils.dart';

class AllCities extends StatelessWidget {
  AllCities({super.key});
  final getIt = GetIt.I;

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
              ))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: black.withOpacity(0.4),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        backButton(context),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    //watch list
                    BlocBuilder<LocalWeatherBloc, LocalWeatherState>(
                      builder: (context, state) {
                        if (state is LocalWeatherFetched) {
                          return state.weathers.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Watch list',
                                      style: TextStyle(color: white),
                                    ),
                                    ...state.weathers.map((e) {
                                      return ListTile(
                                        title: Text(
                                          e.cityName!,
                                          style: const TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          '${e.description!} ',
                                          style: const TextStyle(color: white),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            getIt
                                                .get<LocalWeatherBloc>()
                                                .add(DeleteLocalWeather(e));
                                          },
                                          icon: SvgPicture.asset(
                                            Constants.deleteIcon,
                                            color: white,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    const Divider(),
                                  ],
                                );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    //all cities
                    const Text(
                      'Available cities (Tap  to add to Watch List)',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    ...CityHelper.citiesModeled().map((e) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: InkWell(
                          onTap: () {
                            getIt.get<WeatherBloc>().add(
                                  FetchWeather(
                                    longitude: double.parse(e.longitude!),
                                    latitude: double.parse(e.latitude!),
                                  ),
                                );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Constants.locationIcon,
                                      color: white,
                                      width: 20,
                                    ),
                                    Text(e.cityName!,
                                        style: TextStyle(
                                            color: white.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                                SizedBox(height: size.width * 0.01),
                                Text('${e.cityName}, ${e.country}',
                                    style: const TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
