import 'package:flutter/material.dart';
import 'package:lms/shared/component/component.dart';

PopupMenuItem customNotificationItem(context, index) {
  return PopupMenuItem<int>(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Material(
            shadowColor: Colors.grey[300],
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: imageFromNetwork(
                          url:
                              "https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg",
                          width: 60,
                          height: 60)),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "is Now following you",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "8 min ago",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
