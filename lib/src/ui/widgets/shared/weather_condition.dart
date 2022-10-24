import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../models/weather.dart';
import '../../../state_management/temperature_unit/temperature_unit_cubit.dart';
import '../../../theme/colors.dart';
import '../../../utils/converters.dart';
import 'value_tile.dart';

class WeatherCondition extends StatelessWidget {
  final Weather weather;
  const WeatherCondition({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    //TemperatureUnit unit = GetIt.I.get<TemperatureUnitCubit>().state;
    final size = MediaQuery.of(context).size;

    return BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
        builder: (context, unit) {
      int currentTemp = weather.temperature!.as(unit).round();
      int maxTemp = weather.maxTemperature!.as(unit).round();
      int minTemp = weather.minTemperature!.as(unit).round();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            weather.getIconData(),
            color: Colors.white,
            size: size.width * 0.18,
          ),
          SizedBox(
            height: size.width * 0.07,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: size.width * 0.24),
              Text(
                '$currentTemp°',
                style: TextStyle(
                  fontSize: size.width * 0.18,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  GetIt.I.get<TemperatureUnitCubit>().setTemperatureUnit(
                      unit == TemperatureUnit.celsius
                          ? TemperatureUnit.kelvin
                          : TemperatureUnit.celsius);
                },
                child: Text(
                  unit.toString().split('.').last.toUpperCase(),
                  style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("max", '$maxTemp'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Colors.white,
              )),
            ),
            ValueTile("min", '$minTemp°'),
          ]),
        ],
      );
    });
  }
}
