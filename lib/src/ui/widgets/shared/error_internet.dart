import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';

class ErrorInternent extends StatelessWidget {
   final String? message;
  const ErrorInternent({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      LottieBuilder.asset('assets/lottie/bad_network.json', height: size.width * 0.2,),
       Text( message?? 'You need internet connection to view this feature',
        textAlign: TextAlign.center,
          style: const TextStyle(
              color: black, fontWeight: FontWeight.bold, fontSize: 18)),
    ]);
  }
}
