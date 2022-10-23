import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/ui/widgets/shared/components.dart';
import 'package:weathercourt/src/ui/widgets/shared/error_internet.dart';
import 'package:weathercourt/src/ui/widgets/shared/forecast_line.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text("Today's forecast",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    )),
              ],
            ),
            BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
              builder: (context, state) {
                if (state is Connected) {
                  return Center(
                    child:
                        BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
                      builder: (context, state) {
                        if (state is WeatherForecastSuccess) {
                          return ForecastLine(weathers: state.weathers);
                        } else if (state is WeatherForecastError) {
                          return const Text(
                            'Trouble fetching Weather Forecast',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        }
                        return circularProgress(size.width * 0.05, 2);
                      },
                    ),
                  );
                }
                return const ErrorInternent();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*


*/