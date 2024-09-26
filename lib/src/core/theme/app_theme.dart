import 'package:contact_management/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme=ThemeData(

  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryColor,
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.cyan,
   textTheme: TextTheme(
     titleLarge: GoogleFonts.lato(
       fontSize: 30,
       fontWeight: FontWeight.bold,
       color: kPrimaryColor
     ),
     titleMedium: GoogleFonts.lato(
         fontSize: 22,
         fontWeight: FontWeight.w500,
         color: kPrimaryColor
     ),
     titleSmall: GoogleFonts.lato(
         fontSize: 18,
         fontWeight: FontWeight.w400,
         color: kPrimaryColor
     ),
   ),
  iconTheme: const IconThemeData(
    color: kBackgroundColor,
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: kBackgroundColor,
    iconTheme: IconThemeData(
      size: 30,
      color: kPrimaryColor
    ),
    surfaceTintColor: Colors.transparent
  )

);