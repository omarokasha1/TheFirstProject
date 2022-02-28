import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lms/modules/Auther/dashboard/dashboard_auther.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

import '../shared/component/constants.dart';
import '../shared/network/local/cache_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

// This is a Splash Screen
  @override
  Widget build(BuildContext context) {
    // get token already saved in cache helper before go to screens
    userToken = CacheHelper.get(key: "token");
    print(userToken);
    // AnimatedSplashScreen You appear to the user for a while, and after that you go to the next
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage("assets/images/orange.jpg"),
        width: 120,
        height: 25,
        fit: BoxFit.cover,
      ),
      //if the user already sign in ->go to ZoomDrawerScreen (that contains Drawer Screen  and Home Screen)
      //Or go to LoginScreen
      nextScreen: userToken == null
          ? LoginScreen()
          : userAuthor
              ? ZoomDrawerScreen(
                  widget: DashboardAuthorScreen(),
                )
              : ZoomDrawerScreen(),
      duration: 1,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
