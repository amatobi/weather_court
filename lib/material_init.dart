import 'package:flutter/Material.dart';

import 'src/theme/theme.dart';
import 'src/ui/screens/splash_screen.dart';

class MaterialInit extends StatelessWidget {
  const MaterialInit({super.key});

  @override
  Widget build(BuildContext context) {
  
   return MaterialApp(
      title: 'Weather Court',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),    

     
      home: const SplashScreen(),
     
    );
  }

}

class UnsupportedScreen extends StatelessWidget {
  const UnsupportedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Unsupported Screen type'),
      ),
    );
  }
}