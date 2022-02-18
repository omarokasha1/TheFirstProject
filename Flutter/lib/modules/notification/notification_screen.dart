import 'package:flutter/material.dart';

import '../../shared/component/constants.dart';
import '../../shared/component/popMenuItem.dart';
// this is notification screen contains all user notifications
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        title: const Text(
          "Notification",
          style: TextStyle(color: primaryColor, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      customNotificationItem(context, index),
                  itemCount: 15,
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
