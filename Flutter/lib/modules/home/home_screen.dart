import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/modules/home/view_all_courses_screen.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/modules/user_tracks/cubit/cubit.dart';
import 'package:lms/modules/user_tracks/cubit/states.dart';
import 'package:lms/modules/user_tracks/user_track_overview_screen.dart';
import 'package:lms/modules/user_tracks/user_trcks_enroll_screen.dart';
import 'package:lms/modules/user_tracks/view_all_tracks_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

import '../my_learning/mylearning.dart';

class TransparentBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackCubit,AllTracksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var profileCubit = ProfileCubit.get(context);
            return BlocConsumer<CourseCubit, CourseStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var courseCubit = CourseCubit.get(context);
                return Scaffold(
                  appBar: myAppBar(context,color: primaryColor,iconColor: Colors.white),
                  body: Layout(
                      widget: ScrollConfiguration(
                        behavior: TransparentBehavior(),
                        child: ConditionalBuilder(
                          condition: courseCubit.coursesModel.length != 0 &&
                              profileCubit.model != null,
                          builder: (context) => SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(color: primaryColor),
                                  height: 220.h,
                                  child: Padding(
                                    padding: EdgeInsets.all(35.0.h),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "Hi, ${profileCubit.model!.profile!.userName}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 28.0.sp)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Image.asset(
                                                  'assets/images/hand.png',
                                                  width: 34.w,
                                                  height: 34.h,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              "Lets start learning!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 25.0.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 45.h,
                                          child: TextField(
                                            keyboardType: TextInputType.none,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.r),
                                                borderSide: const BorderSide(
                                                    color: secondaryColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              hintText: "Search Courses",
                                              prefixIcon: const Icon(Icons.search),
                                            ),
                                            onTap: () {
                                              navigator(context, ZoomDrawerScreen(widget: SearchScreen(),));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: (){
                                            navigator(context, ViewAllCoursesScreen());
                                          },
                                          child: Row(
                                            children: [
                                              const Text('Recommended Courses'),
                                              const Spacer(),
                                              const Text(
                                                'View all',
                                              ),
                                              Icon(
                                                Icons.arrow_forward_outlined,
                                                size: 20.w,
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/3,
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              buildCourseItem(context, false,
                                                  courseCubit.coursesModel[index]!),
                                          itemCount: courseCubit.coursesModel.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            navigator(context, ViewAllTracksScreen());
                                          },
                                          child: Row(
                                            children: [
                                              const Text('Recommended Tracks'),
                                              const Spacer(),
                                              const Text(
                                                'View all',
                                              ),
                                              Icon(
                                                Icons.arrow_forward_outlined,
                                                size: 20.w,
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/3,
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>buildUserTracksItem(context, false,TrackCubit.get(context).tracksModel[index]!),
                                          itemCount: TrackCubit.get(context).tracksModel.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Row(
                                          children: [
                                            const Text('My Learning Courses'),
                                            const Spacer(),
                                            const Text(
                                              'View all',
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                navigator(context, MyLearning());
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_outlined,
                                                size: 20.w,
                                                color: primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/3,
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              buildCourseItem(context, true,
                                                  courseCubit.coursesModel[index]!),
                                          itemCount: courseCubit.coursesModel.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )),
                );
              },
            );
          },
        );
      },
    );
  }
}
Widget buildUserTracksItem(context, bool enroll,Tracks tracksModel ) =>
    InkWell(
      onTap: () {
        navigator(
            context,
            enroll
                ? UserTracksEnrollScreen()
                : UserTracksOverViewScreen(tracksModel));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
          width: 300.w,
          decoration: BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.6, 1.2), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: imageFromNetwork(
                          url:
                         // 'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg',),
                        '${tracksModel.imageUrl}'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12.0.w, right: 12.w, top: 5.h, bottom: 5.h),
                        margin: EdgeInsets.all(11.0.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '14 Courses',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //'Complete Instagram Marketing Course',
                       '${tracksModel.trackName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(

                            'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',),
                          //  '${courseModel.author!.imageUrl}'),
                          radius: 16.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Created by ',
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/star.png',width: 20,height: 20,),
                              SizedBox(
                                width: 5.w,
                              ),
                              //Text('${courseModel.review}'),
                              const Text('4.5',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

