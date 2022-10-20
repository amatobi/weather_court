import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logo(Size size) {
  return Text(
    'Weather Court',    
    style: GoogleFonts.fredokaOne(
      fontSize: size.width * 0.13,
      fontWeight: FontWeight.w900, 
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: 2, 
          color: Colors.grey.withOpacity(0.4), 
          offset: const Offset(0, 2)
        )
      ],


    ),
  );
}
