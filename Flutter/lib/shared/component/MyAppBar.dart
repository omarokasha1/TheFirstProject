import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lms/modules/notification/notification_screen.dart';

import 'constants.dart';
import 'popMenuItem.dart';

AppBar myAppBar(context, {Color color=Colors.white,Color iconColor=primaryColor}) {
  return AppBar(
    //status bar setting
    systemOverlayStyle: const SystemUiOverlayStyle(
    //  statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
    leadingWidth: 65,
    elevation: 0,
    backgroundColor: color,
    leading: InkWell(
      //this used to switch between home screen  and drawer
      onTap: () {
        ZoomDrawer.of(context)!.toggle();
      },
      child:  Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Icon(Icons.menu,color: iconColor,)
        // CircleAvatar(
        //   radius: 25,
        //   backgroundColor: Color(0xff067B85),
        //   backgroundImage: CachedNetworkImageProvider(
        //       "https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg"),
        // ),
        
      ),
    ),
    actions: [
      //notifications
      PopupMenuButton(
        icon:  Icon(
          Icons.notifications,
          color: iconColor,
          size: 22,
        ),
        offset: const Offset(-25, 60),
        itemBuilder: (context) => [
          customNotificationItem(context, 0),
          customNotificationItem(context, 1),
          customNotificationItem(context, 2),
          PopupMenuItem<int>(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const Center(child: Text("See More")),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
