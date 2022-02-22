import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_screen.dart';
import 'package:lms/modules/Auther/create_course/create_course_screen.dart';
import 'package:lms/modules/Auther/create_module/create_module_screen.dart';
import 'package:lms/modules/Auther/create_quiz/create_quiz_screen.dart';
import 'package:lms/modules/Auther/modules_library/modules_library.dart';
import 'package:lms/modules/Auther/traks/traks_screen.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:timelines/timelines.dart';

class _SalesData {
  _SalesData(this.year, this.views);

  final String year;
  final double views;
}
bool moveLeft =false;

class DashboardAuthorScreen extends StatefulWidget {
  DashboardAuthorScreen({Key? key}) : super(key: key);

  @override
  State<DashboardAuthorScreen> createState() => _DashboardAuthorScreenState();
}


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
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        //   label: Text('Create',style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          SpeedDialChild(
              child: Icon(Icons.post_add),
              onTap: () {
                navigator(context, CreateQuizScreen());
              },
              label: 'Add Quiz'),
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
        ],
      ),
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container( width: double.infinity,
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
                                  "Hi, Name",
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
                                fontSize: 25.0.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
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
                      child: Column(
                        children: [
                          const Text(
                            'Total students:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          // package to add animation to numbers
                          NumberSlideAnimation(
                            number: "12345",
                            // number
                            duration: const Duration(seconds: 4),
                            //The time specified for the animation
                            curve: Curves.fastOutSlowIn,
                            //animation form
                            textStyle: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
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
                            number: "6234",
                            duration: const Duration(seconds: 4),
                            curve: Curves.fastOutSlowIn,
                            textStyle: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Total Courses:',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                          NumberSlideAnimation(
                            number: "15",
                            duration: const Duration(seconds: 4),
                            curve: Curves.fastOutSlowIn,
                            textStyle: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                            Image.asset('assets/images/online-course.png',
                                width: 60.w, height: 60.h),
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
                          navigator(context, Tracks());
                        },
                        child: Column(
                          children: [
                            Image.asset('assets/images/pointer.png',
                                width: 60.w, height: 60.h),
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
                          navigator(context, ModulesLibraryScreen());
                        },
                        child: Column(
                          children: [
                            Image.asset('assets/images/quiz.png',
                                width: 60.w, height: 60.h),
                            const Text('Assignment',
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
                        radius: 80.0,
                        lineWidth: 18.0,
                        animation: true,
                        percent: 0.7,
                        center: const Text(
                          "70.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: Column(
                          children: [
                            const Text(
                              "Quizzes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            Text(
                              "22 submitted",
                              style: Theme.of(context).textTheme.caption,
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
                        radius: 80.0,
                        lineWidth: 18.0,
                        animation: true,
                        percent: 0.4,
                        center: const Text(
                          "40.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: Column(
                          children: [
                            const Text(
                              "Assignments",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                             Text(
                              "17 completed",
                              style: Theme.of(context).textTheme.caption,
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
                          child: const Text('Top Student',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          setState(() {
                            moveLeft = !moveLeft;
                          });
                        }, icon:Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 300,
                          child: Stack(
                            children: [
                              Positioned(
                                top:24,
                                child: Container(
                                  height: 3,
                                  width: 800.w,
                                  color: primaryColor,
                                ),
                              ),
                              AnimatedPositioned(
                                left:moveLeft? 200:250,
                                duration: Duration(seconds: 3),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                                ),
                              ),
                              AnimatedPositioned(
                                left:moveLeft? 100:120,
                                duration: Duration(seconds: 3),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                                ),
                              ),
                              AnimatedPositioned(
                                left:moveLeft ? 40 : 50,
                                duration: Duration(seconds: 1),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
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
                    title:
                        ChartTitle(text: 'Half yearly courses views analysis'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                          dataSource: data,
                          xValueMapper: (_SalesData views, _) => views.year,
                          yValueMapper: (_SalesData views, _) => views.views,
                          name: 'Views',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
