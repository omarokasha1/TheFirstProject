import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/Auther/%20create_track%20/create_track.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';

import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

import '../author_courses/author_courses_cubit/status.dart';

class Tracks extends StatelessWidget {
  Tracks({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    Tab(text: 'Drafts'),
    Tab(text: 'Pendding'),
    Tab(text: 'Published'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorCourseCubit(),
      child: BlocConsumer<AuthorCourseCubit, AuthorCourseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthorCourseCubit.get(context);
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
                            'Tracks',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              navigator(context, CreateTrackScreen());
                            },
                            child: Text(
                              'New Track',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      labelColor: primaryColor,
                      indicatorColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      tabs: myTabs,
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          publishedCourses(),
                          penddingCourses(),
                          draftsCourses(),
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
  Widget BuildAuthorCourse() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            // Container(
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.white,
            //   ),
            //   child: Image.network(
            //     'https://media.gettyimages.com/vectors/-vector-id960988454',
            //     height: 150.h,
            //     width: 140.w,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://media.gettyimages.com/vectors/-vector-id960988454',
                height: 150.w,
                width: 140.h,
                fit: BoxFit.cover,
              ),
            ),
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
                  Container(
                    child: Text(
                      'Track Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.drafts,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Published Courses PageView
  Widget publishedCourses() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildAuthorCourse();
        },
        itemCount: 10);
  }

  //Pending Courses PageView
  Widget penddingCourses() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildAuthorCourse();
        },
        itemCount: 10);
  }

  //Drafts Courses PageView
  Widget draftsCourses() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildAuthorCourse();
        },
        itemCount: 10);
  }
}
