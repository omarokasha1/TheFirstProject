import 'package:flutter/material.dart';
import 'package:lms/shared/network/local/cache_helper.dart';

const Color primaryColor = Color(0xff07919C);
const Color secondaryColor = Color(0xff3FB8C0);
const textColorDrawer = Colors.white;
const iconColorDrawer = Colors.white;
const shadowColor = Color.fromRGBO(143, 148, 251, .2);

String? userToken = CacheHelper.get(key: "token");

LinearGradient gradientColor({required Color one, required Color two}) {
  return LinearGradient(
    colors: [one, two],
  );
}

bool userAuthor = true;
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

const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Colors.grey;
const kBlackColor = Color(0xFF101010);
const double kDefaultPadding = 20.0;

const String imageUrl = 'http://10.5.62.214:8080/uploads/';
const newVv = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [Color(0xff3FB8C0), Color(0xff0399A0), Color(0xff07919c)],
);
