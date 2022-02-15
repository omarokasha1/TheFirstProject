import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

import 'my_learning/mylearning.dart';

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
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        return BlocConsumer<CourseCubit, CourseStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var courseCubit = CourseCubit.get(context);
            return Scaffold(
              appBar: myAppBar(context),
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
                                      navigator(context, SearchScreen());
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
                                child: Row(
                                  children: [
                                    const Text('Top Courses'),
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
                              SizedBox(
                                height: 300.h,
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
                              SizedBox(
                                height: 330.h,
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
                                height: 300.h,
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
  }
}
