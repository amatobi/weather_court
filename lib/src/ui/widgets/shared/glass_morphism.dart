import 'dart:ui';
import 'package:flutter/material.dart';


class GlassMorphism extends StatelessWidget {
final double blur;
final double opacity; 
final Widget child;
final double radius;
  const GlassMorphism({ 
    Key? key, 
    required this.blur,
    required this.opacity,
    required this.child,
    required this.radius,
   }) 
   : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius:  BorderRadius.all(Radius.circular(radius),
            ),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}