import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lms/modules/home_screen.dart';
import '../../layout/layout.dart';
import 'myDrawer.dart';
//the main screen after the login screen or the splash screen
class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // in zoom drawer switch between drawer and home screen with leading in app bar using (ZoomDrawer.of(context)!.toggle();)
    return const ZoomDrawer(
      //menu screen this is drawer screen
      menuScreen: MyDrawer(),
      //main screen this is home screen
      mainScreen: HomePage(),
      style: DrawerStyle.Style1,
      borderRadius: 40,
      angle: -4,
      //slideWidth: MediaQuery.of(context).size.width*0.66,
      showShadow: true,
      backgroundColor: Colors.white,
    );
  }
}
