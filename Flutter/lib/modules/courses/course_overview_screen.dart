import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_screen.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/shared/component/component.dart';
import '../../shared/component/constants.dart';
import '../../shared/component/zoomDrawer.dart';
import 'course_details_screen.dart';

class CoursesOverViewScreen extends StatelessWidget {
  final Courses courseModel;

  const CoursesOverViewScreen(this.courseModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseCubit.get(context).changeEnrolledCourse(context, courseModel.sId!);
    CourseCubit.get(context).changeWishlistCourse(context, courseModel.sId!);
    return BlocConsumer<CourseCubit,CourseStates>(
      listener: (context, state) {
        if (state is EnrollCourseSuccessState){
          //CourseCubit.get(context).changeEnrolledCourse(context, courseModel.sId!);
          // bool isEnrolled = BlocProvider.of<ProfileCubit>(context).model!.profile!.myCourses!.where((element)  {
          //   return element == courseModel.sId;
          // }).toList().length != 0 ? true:false;
          // BlocProvider.of<CourseCubit>(context).changeEnabledCourse(isEnrolled);
        }else if(state is WishlistCourseSuccessState){
          // bool isWishlist = BlocProvider.of<ProfileCubit>(context).model!.profile!.wishList!.where((element)  {
          //   return element == courseModel.sId;
          // }).toList().length != 0 ? true:false;
          // BlocProvider.of<CourseCubit>(context).changeWishlistCourse(isWishlist);
        }
      },
      builder: (context, state){
        var cubit = CourseCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
          ),
          // create two button in bottomNavigationBar
          bottomNavigationBar: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    // object from defaultButton on component.dart file
                    child: defaultButton(
                      onPressed: () {
                        if(cubit.isEnrolled){
                          navigator(context, ZoomDrawerScreen(widget: CoursesDetailsScreen(courseModel),));
                        }else {
                          cubit.enrollCourse(context, courseId: courseModel.sId);
                          navigator(context, ZoomDrawerScreen(widget: CoursesDetailsScreen(courseModel),));
                        }
                      }, text: cubit.isEnrolled ? 'Go To Course' :'Enroll Course',),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    // object from defaultButton on component.dart file
                    child: defaultButton(onPressed: () {
                      cubit.wishlistCourse(context, courseId: courseModel.sId);
                    }, text: 'Add Wishlist', widget: Icon(cubit.isWishlist ? Icons.favorite_rounded : Icons.favorite_border, color: primaryColor,), color: false),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget display course image in border radius
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: imageFromNetwork(
                        url: '${courseModel.imageUrl}', height: 200.h),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // course title
                  Text(
                    '${courseModel.title}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // course description

                  Text(
                    '${courseModel.description}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // What the course includes

                  // Row Inside tow Column

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        // Column inside text, icon, last update
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Last Updated'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('Last update from model'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        // Column inside text, icon, language
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Language'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${courseModel.language}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Row Inside tow Column
                  Row(
                    children: [
                      Expanded(
                        // Column inside text, icon, Total Time
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Time'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('total time model')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        // Column inside text, icon, Learners number
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Learners'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('${courseModel.learner!.length}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Created by ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // author image in a circular shape
                      InkWell(
                        onTap: (){
                          navigator(context, AuthorProfileScreen(courseModel.author!.sId!));
                        },
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            '${courseModel.author!.imageUrl}',
                          ),
                          radius: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // author name
                      Text('${courseModel.author!.userName}'),
                      const Spacer(),
                      // course rate (title, icon)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor.withOpacity(0.7)),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'review model',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                  const Text(
                    'What you will learn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Course Requirements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${courseModel.requirements}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
