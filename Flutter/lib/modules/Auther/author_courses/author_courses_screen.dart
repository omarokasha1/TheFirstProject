import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_courses/course_view.dart';
import 'package:lms/modules/Auther/author_courses/create_course_screen.dart';
import 'package:lms/modules/Auther/author_courses/update_course_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

import 'author_courses_cubit/status.dart';

class AuthorCourses extends StatelessWidget {
  AuthorCourses({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    //Tab(text: 'Drafts'),
    Tab(text: 'Pendding'),
    Tab(text: 'Published'),

  ];

  var icon = Icons.send;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthorCoursesCubit.get(context);
        return Layout(
          widget: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                condition: cubit.coursesModel != null &&
                    cubit.coursesModelPublish != null,
                builder: (context) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'My Courses',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                navigator(context, CreateCourseScreen());
                              },
                              child: Text(
                                'New Course',
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
                        // isScrollable: true,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: myTabs,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            //Pending Courses
                            ConditionalBuilder(
                              condition:
                              cubit.coursesModel!.courses!.length != 0,
                              builder: (context) {
                                return penddingCourses(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),
                            //Publish Courses
                            ConditionalBuilder(
                              condition:
                                  cubit.coursesModelPublish!.courses!.length != 0,
                              builder: (context) {
                                return publishedCourses(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),

                            //draftsCourses(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  //Published Courses PageView
  Widget publishedCourses(AuthorCoursesCubit cubit,) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildAuthorCourse(context,
              cubit.coursesModelPublish!.courses![index], cubit, false);
        },
        itemCount: cubit.coursesModelPublish!.courses!.length);
  }

  //Pending Courses PageView
  Widget penddingCourses(AuthorCoursesCubit cubit) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildAuthorCourse(
              context, cubit.coursesModel!.courses![index], cubit, true);
        },
        itemCount: cubit.coursesModel!.courses!.length);
  }

  //Course Widget
  Widget buildAuthorCourse(
      context, Courses course, AuthorCoursesCubit cubit, bool request) {
    return InkWell(
      onTap: (){
        navigator(context, CourseDetailsScreen(course));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Container(
          height: 110.h,
          padding: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                offset: Offset(0.6, 1.2), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: imageFromNetwork(
                    //'https://media.gettyimages.com/vectors/-vector-id960988454',
                    url: '${course.imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      '${course.title}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 30,
                    color: primaryColor,
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {
                            navigator(context, UpdateCourseScreen(course));
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit')),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {
                            print(course.sId);
                            cubit.deleteCourse(courseId: course.sId!);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          )),
                      value: 2,
                    ),
                    if (request)
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: () {
                              cubit.sendNewCourseRequest(courseId: course.sId);
                              print(course.sId.toString());
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.green,
                            ),
                            label: const Text(
                              'Request',
                              style: TextStyle(color: Colors.green),
                            )),
                        value: 3,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
