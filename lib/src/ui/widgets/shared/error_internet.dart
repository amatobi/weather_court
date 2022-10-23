import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';

class ErrorInternent extends StatelessWidget {
   final String? message;
  const ErrorInternent({super.key, this.message});

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      LottieBuilder.asset('assets/lottie/no_connectivity.json', height: 150,),
       Text( message?? 'You need internet connection to view this feature',
        textAlign: TextAlign.center,
          style: const TextStyle(
              color: black, fontWeight: FontWeight.bold, fontSize: 18)),
    ]);
  }
}
