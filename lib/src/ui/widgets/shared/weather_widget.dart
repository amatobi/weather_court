import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathercourt/src/ui/widgets/shared/value_tile.dart';
import 'package:weathercourt/src/ui/widgets/shared/weather_condition.dart';

import '../../../models/weather.dart';



class WeatherWidget extends StatelessWidget {
  final Weather? weather;

  const WeatherWidget({super.key, this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
              
          Text(
            weather!.cityName!.toUpperCase(),
            style: const TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            weather!.description!.toUpperCase(),
            style: const TextStyle(
                fontSize: 15,
                letterSpacing: 5,
                fontWeight: FontWeight.w100,
                color: Colors.white),
          ),
          WeatherCondition(weather: weather!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueTile("wind speed", '${weather!.windSpeed} m/s'),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Colors.white,
                )),
              ),
              ValueTile(
                  "sunrise",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          weather!.sunrise! * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Colors.white,
                )),
              ),
              ValueTile(
                  "sunset",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          weather!.sunset! * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Colors.white,
                )),
              ),
              ValueTile("humidity", '${weather!.humidity}%'),
            ],
          ),
          //ForecastWidget(weathers: weather!,)
        ],
      ),
    );
  }
}
