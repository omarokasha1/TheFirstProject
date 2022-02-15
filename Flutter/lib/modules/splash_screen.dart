import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

import '../shared/component/constants.dart';
import '../shared/network/local/cache_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     userToken = CacheHelper.get(key: "token");
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage("assets/images/orange.jpg"),
        width: 120,
        height: 25,
        fit: BoxFit.cover,
      ),
      nextScreen: userToken == null ? LoginScreen() : ZoomDrawerScreen(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.white,
    );
  }
}
