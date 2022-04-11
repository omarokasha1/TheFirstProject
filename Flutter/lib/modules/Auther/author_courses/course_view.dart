import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/modules/Auther/author_courses/contant_view.dart';
import 'package:lms/modules/Auther/modules/module_view.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:readmore/readmore.dart';
import '../../../models/new/contents_model.dart';
import '../../../models/new/courses_model.dart';
import '../modules/assignment_view.dart';


class CourseDetailsScreen extends StatelessWidget {
  final Courses course;
  CourseDetailsScreen(this.course, {Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Content'),
    const Tab(text: 'Assignment'),
    //const Tab(text: 'Quizzes'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorCoursesCubit(),
      child: BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit =AuthorCoursesCubit.get(context);
            return DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: imageFromNetwork(
                              url:"${course.imageUrl}",
                                 // 'https://www.drjimtaylor.com/4.0/wp-content/uploads/2019/12/Online-courses.jpg',
                              height: 130.h),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${course.title}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ReadMoreText(
                            "${course.description}",
                            trimLines: 3,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            lessStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Requirement:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ReadMoreText(
                            "${course.requirements}",
                            trimLines: 3,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            lessStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Language : ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${course.language}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TabBar(
                          labelColor: primaryColor,
                          indicatorColor: primaryColor,
                          unselectedLabelColor: Colors.black45,
                          //isScrollable: true,
                          tabs: myTabs,
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => builtCourseContant(context, course.contents![index]),
                                  itemCount: course.contents!.length),
                              ConditionalBuilder(
                                condition: course.assignment != null,
                                builder: (context){
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      //    physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          builtCourseAssignment(context, course.assignment![index]),
                                      itemCount: course.assignment!.length);
                                },
                                fallback: (context){
                                  return emptyPage(text: "No Assignment", context: context);
                                },
                              ),
                              // ListView.builder(
                              //     shrinkWrap: true,
                              //     //  physics: NeverScrollableScrollPhysics(),
                              //     itemBuilder: (context, index) =>
                              //         builtCourseContant(context, course.contents![index]),
                              //     itemCount: course.contents!.length),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

Widget builtCourseContant(context, Contents content) {
  return InkWell(
    onTap: (){
      navigator(context, ContentViewScreen(content));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_arrow_outlined),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 100.w,
                          child: Text(
                            //'File Name File Name File Name File Name ',
                            '${content.contentTitle}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          //'3 min ',
                          content.contentDuration ?? '',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Text(
                      //'short description ',
                      content.description ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget builtCourseAssignment(context,Assignment assignment) {
  return InkWell(
    onTap: (){
      navigator(context, AssignmentDetailsScreen(assignment));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.file_copy_outlined),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150.w,
                          child: Text(
                            assignment.assignmentTitle ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          assignment.assignmentDuration!.replaceAll('min', 'M').replaceAll('Hours', 'H').replaceAll('Minutes', 'M'),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Container(
                      width: 250.w,
                      child: Text(
                        assignment.description ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
