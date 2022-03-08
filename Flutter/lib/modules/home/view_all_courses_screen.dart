import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/network/end_points.dart';

class ViewAllCoursesScreen extends StatelessWidget {
  const ViewAllCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of(context),
      child: BlocConsumer<CourseCubit, CourseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildCourseItem(context, true,
                        CourseCubit.get(context).coursesModel[index]!),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 10),
              ));
        },
      ),
    );
  }
}
