import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/ui/widgets/shared/error_internet.dart';
import 'package:weathercourt/src/ui/widgets/shared/forecast_line.dart';

import '../../../models/weather.dart';

class ForecastWidget extends StatelessWidget {
  final List<Weather> weathers;
  const ForecastWidget({
    required this.weathers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.285,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
           
            BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
              builder: (context, state) {
                if (state is Connected) {
                  return Center(
                    child:  ForecastLine(weathers: weathers),
                        //return circularProgress(size.width * 0.05, 2);
                       
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