import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  List search = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CourseCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: myAppBar(
            context,
          ),
          body: Layout(
            widget: Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: primaryColor,
                      decoration: const InputDecoration(
                        fillColor: primaryColor,
                        iconColor: primaryColor,
                        border: InputBorder.none,
                        hintText: "Search Courses",
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: primaryColor,
                        ),
                        prefixIconColor: primaryColor,
                      ),
                      onChanged: (value) {
                        //call database to get Search
                        cubit.searchCourse(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "All Results",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.search.isNotEmpty,
                      builder: (context){
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCourseItem(
                                context,
                                false,
                                cubit.search[index]);
                          },
                          itemCount: cubit.search.length,
                        );
                      },
                      fallback: (context){
                        return Center(child: emptyPage(text: 'There\'s No Courses Which your Search', context: context),);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
