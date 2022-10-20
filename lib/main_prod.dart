import 'package:flutter/material.dart';
import 'package:weathercourt/src/config/constants.dart';


import 'composition_root.dart';
import 'src/config/app_config.dart';

///This is the development flavour of the project, run like so 
///flutter run --flavor weatherProd -t lib/main_prod.dart


Future<void> main() async{
  var spec = const AppConfig(
    appName: Constants.appName,
    flavorName: 'Production',
    baseApi: Constants.openWeatherMapBaseApi,
    child: WeatherCourt(),
  );
 await CompositionRoot.configure();

  runApp(spec);
}

class WeatherCourt extends StatelessWidget {
  const WeatherCourt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return CompositionRoot.start();
  }
}

