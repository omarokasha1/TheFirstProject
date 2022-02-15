import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff07919C);
const Color secondaryColor = Color(0xff3FB8C0);
const textColorDrawer = Colors.white;
const iconColorDrawer = Colors.white;
const shadowColor = Color.fromRGBO(143, 148, 251, .2);
String? userToken;

LinearGradient gradientColor({required Color one, required Color two}) {
  return LinearGradient(
    colors: [one, two],
  );
}

const gray = Color(0xfffafafa);

const grayText = Color(0xff9F9D9B);

const MaterialColor color = MaterialColor(
  0xff07919C,
  // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0xff079191), //10%
    100: Color(0xff079192), //20%
    200: Color(0xff079193), //30%
    300: Color(0xff079194), //40%
    400: Color(0xff079195), //50%
    500: Color(0xff07919C), //60%
    600: Color(0xff07919C), //70%
    700: Color(0xff07919C), //80%
    800: Color(0xff07919C), //90%
    900: Color(0xff07919C), //100%
  },
);
bool connected = true;
