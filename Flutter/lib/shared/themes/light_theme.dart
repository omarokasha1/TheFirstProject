import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/constants.dart';

//Here we Build light Theme
ThemeData lightTheme(context) {
  return ThemeData(
    textTheme: GoogleFonts.nunitoTextTheme(
      Theme.of(context).textTheme,
    ).apply(bodyColor: Colors.black54),
    primarySwatch: color,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      toolbarHeight: 80,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(),
    ),
  );
}
