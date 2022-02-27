import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/manager/bloc/cubit.dart';
import 'package:lms/modules/manager/bloc/states.dart';

import 'package:lms/shared/component/constants.dart';

class AuthorRequest extends StatelessWidget {
  AuthorRequest({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    Tab(text: 'Courses'),
    Tab(text: 'Tracks'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerCubit(),
      child: BlocConsumer<ManagerCubit, ManagerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ManagerCubit.get(context);
          return Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Requests',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      labelColor: primaryColor,
                      indicatorColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      tabs: myTabs,
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child:TabBarView(
                        children: [
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => AuthorCourseCard(),
                              itemCount: 10),
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index)=> AuthorTrackCard(),
                              itemCount: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Course Widget
  Widget AuthorCourseCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [

            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Flutter Crash Course',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                      radius: 18,
                    ),
                    SizedBox(
                      width: 10,),
                    Container(
                      width: 100.w,
                      child: Text(
                        'authorName authorName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Spacer(),
                    TextButton(onPressed: (){}, child: Text('Accept')),
                    TextButton(onPressed: (){}, child: Text('Decline',style: TextStyle(color: Colors.red),)),
                    // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.green,) ,onPressed: (){}, child: Text("Accept"),),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.red, ) ,onPressed: (){}, child: const Text("Decline")),

                  ],),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget AuthorTrackCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [

            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Web Development Full stack Track ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                      radius: 18,
                    ),
                    SizedBox(
                      width: 10,),
                    Container(
                      width: 100.w,
                      child: Text(
                        'authorName authorName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Spacer(),
                    TextButton(onPressed: (){}, child: Text('Accept')),
                    TextButton(onPressed: (){}, child: Text('Decline',style: TextStyle(color: Colors.red),)),
                    // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.green,) ,onPressed: (){}, child: Text("Accept"),),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.red, ) ,onPressed: (){}, child: const Text("Decline")),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    // SizedBox(height: 8.h,),

                  ],),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}