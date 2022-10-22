import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/ui/widgets/shared/error_internet.dart';

import '../../../state_management/weather_forecast/weather_forecast_cubit.dart';
import '../../../theme/colors.dart';

class ForecastWidget extends StatelessWidget {
  //final Weather weathers;
  const ForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        if (state is Connected) {
          return BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
            builder: (context, state) {
              if (state is WeatherForecastSuccess) {
                return Container(
                  width: size.width,
                  height: size.height * 0.25,
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  width: size.width * 0.10,
                  height: size.width * 0.10,
                  child: const CircularProgressIndicator(
                    color: primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          );
        }
        return ErrorInternent();
      },
    );
  }
}

/*
ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.weathers.length,
        separatorBuilder: (context, index) => Divider(
              height: 100,
              color: Colors.white,
            ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
              '${item.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
              iconData: item.getIconData(),
            )),
          );
        },
      ),

*/