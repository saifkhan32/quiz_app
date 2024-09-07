import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(fontFamily: GoogleFonts.nunito().fontFamily,
    primarySwatch: Colors.blueGrey,
      brightness: Brightness.light,
      textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 26),
      bodyMedium: TextStyle(fontSize: 35) ,
      titleSmall: TextStyle(color: Colors.grey)),
      dialogBackgroundColor: Colors.blueGrey);