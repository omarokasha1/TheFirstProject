import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lms/modules/home_screen.dart';
import '../../layout/layout.dart';
import 'myDrawer.dart';

class ZoomDrawerScreen extends StatelessWidget {
  final Widget widget;
   ZoomDrawerScreen({this.widget=const HomePage(),Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MyDrawer(),
      mainScreen: widget,
      style: DrawerStyle.Style1,
      borderRadius: 40,
      angle: -4,
      //slideWidth: MediaQuery.of(context).size.width*0.66,
      showShadow: true,
      backgroundColor: Colors.white,
    );
  }
}
