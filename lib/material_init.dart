import 'package:flutter/Material.dart';
import 'package:weathercourt/src/config/app_config.dart';

import 'src/theme/theme.dart';
import 'src/ui/screens/splash_screen.dart';

class MaterialInit extends StatelessWidget {
  const MaterialInit({super.key});

  @override
  Widget build(BuildContext context) {
  
   return MaterialApp(
      title: AppConfig.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),    

     
      home: const SplashScreen(),
     
    );
  }

}

