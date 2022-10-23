import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:weathercourt/src/theme/colors.dart';

import '../../../models/weather.dart';
import '../../../state_management/temperature_unit/temperature_unit_cubit.dart';
import 'value_tile.dart';

class ForecastLine extends StatelessWidget {
  final List<Weather> weathers;
  const ForecastLine({super.key, required this.weathers});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final getIt = GetIt.I;
    return SizedBox(
      width: size.width,
      height: size.width * 0.487, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weathers.length,
        separatorBuilder: (context, index) => const Divider(
          height: 100,
          color: black,
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, ha')
                  .format(DateTime.fromMillisecondsSinceEpoch(item.time! * 1000)),
              '${item.temperature!.as(getIt.get<TemperatureUnitCubit>().state).round()}°',
              textColor: black,
              iconData: item.getIconData(),
            )),
          );
        },
      ),
    );
  }
}
