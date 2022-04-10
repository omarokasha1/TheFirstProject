import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/network/end_points.dart';

class ViewAllCoursesScreen extends StatelessWidget {
  List<Courses> model =[];
  ViewAllCoursesScreen(this.model,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
            body:ListView.builder(
                 itemCount: model.length,
                itemBuilder: (context, index) => buildCourseItem(context, false,
                  model[index]))
          // ListView.separated(
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) => buildCourseItem(context, true,
          //         CourseCubit.get(context).coursesModel[index]!),
          //     separatorBuilder: (context, index) =>  SizedBox(
          //       height: 10,
          //     ),
          //     itemCount: 10)

        );
      },
    );
  }
}
