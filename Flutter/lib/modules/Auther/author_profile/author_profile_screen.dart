import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_cubit/state.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/home/home_screen.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

class AuthorProfileScreen extends StatelessWidget {
  final String authorID;
  AuthorProfileScreen(this.authorID, {Key? key}) : super(key: key);

  File? profileImage;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AuthorProfileCubit>(context)..getAuthorProfile(authorID),
      child: BlocConsumer<AuthorProfileCubit, AuthorProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthorProfileCubit.get(context);
          var courseCubit = CourseCubit.get(context);
          return Layout(
            widget: ConditionalBuilder(
              condition: cubit.model != null,
              builder: (context) => Scaffold(
                backgroundColor: primaryColor,
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // navigatorAndRemove(
                      //   context,
                      //   ZoomDrawerScreen(
                      //     widget: HomePage(),
                      //   ),
                      // );
                    },
                  ),
                ),
                body: ConditionalBuilder(
                  condition: cubit.model != null && cubit.model!.profile != null,
                  builder: (context) => Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 45.0,
                            backgroundImage: CachedNetworkImageProvider(
                              '${cubit.model!.profile!.imageUrl}',
                            ),
                            // child: Align(
                            //   alignment: AlignmentDirectional.bottomEnd,
                            //   child: CircleAvatar(
                            //     radius: 16.0,
                            //     backgroundColor: Colors.white,
                            //     child: CircleAvatar(
                            //       backgroundColor: primaryColor,
                            //       radius: 15.0,
                            //       child: IconButton(
                            //         icon: Icon(
                            //           Icons.camera_alt_outlined,
                            //         ),
                            //         color: Colors.white,
                            //         iconSize: 15.0,
                            //         onPressed: () async {
                            //           final pickedFile = await picker.pickImage(
                            //               source: ImageSource.gallery);
                            //           if (pickedFile != null) {
                            //             profileImage = File(pickedFile.path);
                            //           } else {
                            //             print('no image selected');
                            //           }
                            //           //image = await _picker.pickImage(source: ImageSource.gallery);
                            //           print(
                            //               "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "${cubit.model!.profile!.userName}",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "${cubit.model!.profile!.bio}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Tracks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '4.3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Icon(
                                      Icons.person,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      "Personal",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    "${cubit.model!.profile!.email}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    "${cubit.model!.profile!.gender}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${cubit.model!.profile!.city} ",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      Text(
                                        "${cubit.model!.profile!.country}",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${cubit.model!.profile!.birthDay}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ListTile(
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Icon(
                                      Icons.science_rounded,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      "Educational",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${cubit.model!.profile!.userEducation!.faculty}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    "${cubit.model!.profile!.userEducation!.university}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    "${cubit.model!.profile!.userEducation!.major}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Grade ${cubit.model!.profile!.userEducation!.grade}",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ListTile(
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Icon(
                                      Icons.work_rounded,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      "Experience",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    "${cubit.model!.profile!.userEducation!.experince}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ListTile(
                                          horizontalTitleGap: 0,
                                          contentPadding: EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.track_changes_rounded,
                                            color: primaryColor,
                                          ),
                                          title: Text(
                                            "Tracks",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        'View all',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 20.w,
                                        color: primaryColor,
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 300.h,
                                    child: ConditionalBuilder(
                                      condition: courseCubit.coursesModel.length != 0 ,
                                      builder: (context) => ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            buildCourseItem(context, false, courseCubit.coursesModel[index]!),
                                        itemCount: courseCubit.coursesModel.length,
                                      ),
                                      fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ListTile(
                                          horizontalTitleGap: 0,
                                          contentPadding: EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.book_rounded,
                                            color: primaryColor,
                                          ),
                                          title: Text(
                                            "Courses",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      const Text(
                                        'View all',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 20.w,
                                        color: primaryColor,
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 300.h,
                                    child: ConditionalBuilder(
                                      condition:
                                      courseCubit.coursesModel.length != 0,
                                      builder: (context) => ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            buildCourseItem(context, false,
                                                courseCubit.coursesModel[index]!),
                                        itemCount: courseCubit.coursesModel.length,
                                      ),
                                      fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      ),
    );
  }

  Widget buildInterestItem(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
