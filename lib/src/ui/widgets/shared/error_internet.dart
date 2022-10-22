import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';

class ErrorInternent extends StatelessWidget {
  const ErrorInternent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      LottieBuilder.asset('assets/lottie/no_connectivity.json'),
      const Text('You need internet to access all features',
          style: TextStyle(
              color: black, fontWeight: FontWeight.bold, fontSize: 18)),
    ]);
  }
}
