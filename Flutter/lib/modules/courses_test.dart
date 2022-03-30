import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/new/course_cubit/course_cubit.dart';
import 'package:lms/shared/component/constants.dart';

import 'new/course_cubit/course_state.dart';

class CoursesTestScreen extends StatelessWidget {
  const CoursesTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CourseCubit()..getAllCoursesData(),
        child: BlocConsumer<CourseCubit, CourseStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var courseCubit = CourseCubit.get(context);
            return ConditionalBuilder(
              condition: courseCubit.coursesModel != null,
              builder: (context) => ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildCourseItems(
                      context, courseCubit.coursesModel!.courses![index]),
                  itemCount: courseCubit.coursesModel!.courses!.length),
              fallback: (context) => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildCourseItems(context, Courses courseModel) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        //'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                        courseModel.imageUrl!,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${courseModel.contents!.length} Modules',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //'Instagram Marketing Course',
                    courseModel.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          //'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                          courseModel.author!.imageUrl!,
                        ),
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Created by ${courseModel.author!.userName!}'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3),
                        decoration: BoxDecoration(
                          color: gray,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('4.5'),
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
    );
