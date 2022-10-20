import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logo(Size size) {
  return Text(
    'Weather Court',
    textAlign: TextAlign.center,
    style: GoogleFonts.fredokaOne(
      fontSize: size.width * 0.11,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      shadows: [
        Shadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 4))
      ],
    ),
  );
}
