
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
  backgroundColor: Colors.white,
);
final dividerTheme = const DividerThemeData().copyWith(thickness: 1.0, indent: 0.0);
ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: primary,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme,
    
      dividerTheme: dividerTheme.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: iconColor),
      textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme)
          .apply(displayColor: textColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );