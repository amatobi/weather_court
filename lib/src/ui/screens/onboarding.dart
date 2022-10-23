import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathercourt/src/state_management/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:weathercourt/src/theme/colors.dart';
import 'package:weathercourt/src/ui/widgets/shared/components.dart';
import 'package:weathercourt/src/ui/widgets/shared/error_internet.dart';
import '../../config/constants.dart';
import '../../helper/onboard.dart';
import '../../state_management/local_weather/local_weather_bloc.dart';
import '../widgets/shared/custom_page_route.dart';
import 'home_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final getIt = GetIt.instance;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  initialize() async {
    getIt.get<Onboard>().setup((b) {
      if (b) {
        getIt.get<LocalWeatherBloc>().add(FetchLocalWeather());

        navigate(const HomeScreen());
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
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/hello.png',
                    height: size.width * 0.7),
                SizedBox(height: size.width * 0.1),
                BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
                  builder: (context, state) {
                    if (state is Connected) {
                      return Column(
                        children: [
                          circularProgress(size.width * 0.05, 2),
                          SizedBox(height: size.width * 0.06),
                          Text('Welcome',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.fredokaOne(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25,
                                  color: black.withOpacity(0.7))),
                          SizedBox(height: size.width * 0.03),
                          Text(
                            'One little raindrop left. A moment please!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: const [
                        ErrorInternent(
                          message:
                              "You do not have an internet connection, We can't get the latest weather for you",
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
