import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_screen.dart';
import 'package:lms/modules/Auther/author_courses/create_course_screen.dart';
import 'package:lms/modules/Auther/modules/create_assigment/create_assignment.dart';
import 'package:lms/modules/Auther/modules/create_module/create_module_screen.dart';
import 'package:lms/modules/Auther/modules/modules_library.dart';
import 'package:lms/modules/Auther/quiz/author_quiz_screen.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/create_quiz_screen.dart';
import 'package:lms/modules/Auther/traks/create_track/create_track.dart';
import 'package:lms/modules/Auther/traks/traks_screen.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class _SalesData {
  _SalesData(this.year, this.views);

  final String year;
  final double views;
}

bool moveLeft = false;

class DashboardAuthorScreen extends StatefulWidget {
  DashboardAuthorScreen({Key? key}) : super(key: key);

  @override
  State<DashboardAuthorScreen> createState() => _DashboardAuthorScreenState();
}

var formKey = GlobalKey<FormState>();
var quizController = TextEditingController();

class _DashboardAuthorScreenState extends State<DashboardAuthorScreen> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      setState(() {
        moveLeft = !moveLeft;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          floatingActionButton: cubit.model != null
              ? SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  //   label: Text('Create',style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    SpeedDialChild(
                        child: Icon(Icons.post_add),
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.QUESTION,
                            body: Form(
                              key: formKey,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      customTextFormFieldWidget(
                                          type: TextInputType.text,
                                          prefixIcon:
                                              Icons.drive_file_rename_outline,
                                          prefix: true,
                                          label: "Quiz Name",
                                          controller: quizController,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'Quiz Name Must Be Not Empty';
                                            }
                                            return null;
                                          }),
                                      Container(
                                        height: 40,
                                        child: defaultButton(
                                            text: 'OK',
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateQuizScreen(
                                                                quizController
                                                                    .text))).then(
                                                  (value) {
                                                    quizController.text = "";
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            title: 'This is Ignored',
                            desc: 'This is also Ignored',

                            // btnOkOnPress: () {
                            //   navigator(context, CreateQuizScreen());
                            // },
                          ).show();
                        },
                        label: 'Add Quiz'),
                    SpeedDialChild(
                        child: Icon(Icons.description),
                        onTap: () {
                          navigator(context, CreateAssignmentScreen());
                        },
                        label: 'Add Assignment'),
                    SpeedDialChild(
                        child: Icon(Icons.play_circle_fill),
                        onTap: () {
                          navigator(context, CreateModuleScreen());
                        },
                        label: 'Add Module'),
                    SpeedDialChild(
                        child: Icon(Icons.add),
                        onTap: () {
                          navigator(context, CreateCourseScreen());
                        },
                        label: 'Add Course'),
                    SpeedDialChild(
                        child: Icon(Icons.location_on_outlined),
                        onTap: () {
                          navigator(context, CreateTrackScreen());
                        },
                        label: 'Add Track'),
                  ],
                )
              : null,
          appBar: myAppBar(context),
          body: ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: newVv,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          "Hi, ${cubit.model!.profile!.userName}",
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
                                    "Lets start teaching!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 25.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   height: 45.h,
                            //   child: TextField(
                            //     keyboardType: TextInputType.none,
                            //     cursorColor: primaryColor,
                            //     decoration: InputDecoration(
                            //       fillColor: Colors.white,
                            //       filled: true,
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(18.r),
                            //         borderSide:
                            //         const BorderSide(color: Colors.white),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(18.r),
                            //         borderSide:
                            //         const BorderSide(color: secondaryColor),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(18.r),
                            //         borderSide:
                            //         const BorderSide(color: Colors.white),
                            //       ),
                            //       hintText: "Search Courses",
                            //       prefixIcon: const Icon(Icons.search),
                            //     ),
                            //     onTap: () {
                            //       navigator(
                            //           context,
                            //           ZoomDrawerScreen(
                            //             widget: SearchScreen(),
                            //           ));
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var cubit = AuthorCoursesCubit.get(context);
                          print('kareem -> ${cubit.totalStudent}');
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Total students',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                      // package to add animation to numbers
                                      Text(
                                        '${cubit.totalStudent}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // NumberSlideAnimation(
                                      //   //number: "12345",
                                      //   number: '${cubit.totalStudent}',
                                      //   // number
                                      //   duration: const Duration(seconds: 4),
                                      //   //The time specified for the animation
                                      //   curve: Curves.fastOutSlowIn,
                                      //   //animation form
                                      //   textStyle: const TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Reviews',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor)),
                                      NumberSlideAnimation(
                                        number: "0",
                                        duration: const Duration(seconds: 4),
                                        curve: Curves.fastOutSlowIn,
                                        textStyle: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Total Courses',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor)),
                                      // Text("${cubit.coursesModelPublish == null ? 0 :  cubit.coursesModelPublish!.courses!.length}",
                                      //     style: TextStyle(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: primaryColor)),
                                      Text(
                                        '${cubit.coursesModelPublish == null ? 0 : cubit.coursesModelPublish!.courses!.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // NumberSlideAnimation(
                                      //   number: "${cubit.coursesModelPublish ==
                                      //       null ? 0 : cubit
                                      //       .coursesModelPublish!.courses!
                                      //       .length}",
                                      //   //number: "123",
                                      //   //duration: const Duration(seconds: 4),
                                      //   curve: Curves.fastOutSlowIn,
                                      //   textStyle: const TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigator(context, AuthorCourses());
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/online-course.png',
                                        width: 50.w,
                                        height: 50.h),
                                    const Text(
                                      'Courses',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigator(context, TracksScreen());
                                },
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/pointer.png',
                                        width: 50.w, height: 50.h),
                                    const Text('Tracks',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigator(context, AuthorQuizScreen());
                                },
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/quiz.png',
                                        width: 50.w, height: 50.h),
                                    const Text('Quiz',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigator(context, ModulesLibraryScreen());
                                },
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/modules.png',
                                        width: 50.w, height: 50.h),
                                    const Text('Module',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[100]),
                              child: CircularPercentIndicator(
                                radius: 68.0,
                                lineWidth: 12.0,
                                animation: true,
                                percent: 0.7,
                                center: const Text(
                                  "70.0%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: Column(
                                  children: [
                                    const Text(
                                      "Quizzes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                    Text(
                                      "22 submitted",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[100]),
                              // Package to display percentage inside a circle
                              child: CircularPercentIndicator(
                                radius: 68.0,
                                lineWidth: 12.0,
                                animation: true,
                                percent: 0.4,
                                center: const Text(
                                  "40.0%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: Column(
                                  children: [
                                    const Text(
                                      "Assignments",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                    Text(
                                      "17 completed",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: const Text(
                                    'Top Student',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        moveLeft = !moveLeft;
                                      });
                                    },
                                    icon: Icon(Icons.refresh))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 300,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 24,
                                        child: Container(
                                          height: 3,
                                          width: 800.w,
                                          color: primaryColor,
                                        ),
                                      ),
                                      AnimatedPositioned(
                                        left: moveLeft ? 200 : 250,
                                        duration: Duration(seconds: 3),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              '${cubit.model!.profile!.imageUrl}'),
                                        ),
                                      ),
                                      AnimatedPositioned(
                                        left: moveLeft ? 100 : 120,
                                        duration: Duration(seconds: 3),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                            '${cubit.model!.profile!.imageUrl}',
                                          ),
                                        ),
                                      ),
                                      AnimatedPositioned(
                                        left: moveLeft ? 40 : 50,
                                        duration: Duration(seconds: 1),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              '${cubit.model!.profile!.imageUrl}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //LottieBuilder.network('https://assets8.lottiefiles.com/packages/lf20_qtt2dv.json',width: 60.w,height: 60.h,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[100],
                        ),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),

                          // Chart title
                          title: ChartTitle(
                              text: 'Half yearly courses views analysis'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (_SalesData views, _) => views.year,
                              yValueMapper: (_SalesData views, _) =>
                                  views.views,
                              name: 'Views',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        );
      },
    );
  }
}
