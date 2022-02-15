import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lms/modules/home_screen.dart';
import '../../layout/layout.dart';
import 'myDrawer.dart';

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      menuScreen: MyDrawer(),
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
