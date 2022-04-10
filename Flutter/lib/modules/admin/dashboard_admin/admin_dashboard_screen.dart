import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/traks/create_track/cubit/cubit.dart';
import 'package:lms/modules/admin/cubit/cubit.dart';
import 'package:lms/modules/admin/cubit/states.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/modules/user_tracks/cubit/cubit.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Auther/author_courses/author_courses_cubit/cubit.dart';

class _SalesData {
  _SalesData(this.year, this.views);

  final String year;
  final double views;
}

class DashboardAdminScreen extends StatelessWidget {
  DashboardAdminScreen({Key? key}) : super(key: key);

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 50),
    _SalesData('Jul', 60),
    _SalesData('Aug', 20),
    _SalesData('Sept', 80),
    _SalesData('Oct', 40),
    _SalesData('Nov', 20),
    _SalesData('Dec', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: myAppBar(context),
          body: ConditionalBuilder(
            condition: cubit.manager != null &&
                cubit.author != null &&
                cubit.allUsersModel != null &&
                cubit.user != null &&
                cubit.numberOfCourses != null &&
                cubit.trackNumber != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
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
                                    Text("Hi, Admin",
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 45.h,
                          //   child: TextField(
                          //     cursorColor: primaryColor,
                          //     decoration: InputDecoration(
                          //       fillColor: Colors.white,
                          //       filled: true,
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(18.r),
                          //         borderSide:
                          //             const BorderSide(color: Colors.white),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(18.r),
                          //         borderSide:
                          //             const BorderSide(color: secondaryColor),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(18.r),
                          //         borderSide:
                          //             const BorderSide(color: Colors.white),
                          //       ),
                          //       hintText: "Search Courses",
                          //       prefixIcon: const Icon(Icons.search),
                          //     ),
                          //     onTap: () {
                          //       navigator(context, SearchScreen());
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daily OverView ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '5,000',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const Text('Users Today'),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Text(
                                          '8,000',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text('Expected Users'),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 4.0,
                                        percent: 0.6,
                                        //   linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 17,
                                    ),
                                    Text(
                                      '25%',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("Since Yesterday"),
                                    Spacer(),
                                    Text(
                                      "60.0%",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
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
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Total Users',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                    // package to add animation to numbers
                                    NumberSlideAnimation(
                                      number: "${cubit.allUsersModel!.users!.length}",
                                      // number
                                      duration: const Duration(seconds: 4),
                                      //The time specified for the animation
                                      curve: Curves.fastOutSlowIn,
                                      //animation form
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
                                    const Text('Total Author',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                      NumberSlideAnimation(
                                      number: "${cubit.author.length}",
                                      //number: '5',
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
                                    const Text('Managers',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                      NumberSlideAnimation(
                                      number: "${cubit.manager.length}",
                                      duration: const Duration(seconds: 4),
                                      curve: Curves.fastOutSlowIn,
                                      textStyle: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Total Courses',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                    // package to add animation to numbers

                                      NumberSlideAnimation(
                                      number:
                                          "${cubit.numberOfCourses!.courses!.length}",
                                      // number
                                      duration: const Duration(seconds: 4),
                                      //The time specified for the animation
                                      curve: Curves.fastOutSlowIn,
                                      //animation form
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
                                    const Text('Total Tracks',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                    NumberSlideAnimation(
                                      number:
                                          "${cubit.trackNumber!.tracks!.length}",
                                      duration: const Duration(seconds: 4),
                                      curve: Curves.fastOutSlowIn,
                                      textStyle: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100]),
                            // Package to display percentage inside a circle
                            child: Column(
                              children: [
                                const Text(
                                  'Active Users',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ConditionalBuilder(
                                  condition: cubit.user.length !=0,
                                  builder: (context)=>ListView.separated(
                                    physics:NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${cubit.user[index].imageUrl}'),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  '${cubit.user[index].userName}'),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text('+12.8%',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      separatorBuilder: (context, index) =>
                                      const Divider(),
                                      itemCount: 3),
                                  fallback: (context)=>Center(child: CircularProgressIndicator.adaptive(),),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100]),
                            // Package to display percentage inside a circle
                            child: Column(
                              children: [
                                const Text(
                                  'Active Author',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ConditionalBuilder(
                                  condition: cubit.manager.length !=0,
                                  builder:(context)=>ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${cubit.manager[index].imageUrl}'),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  '${cubit.manager[index].userName}'),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              const Text('+12.8%',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      separatorBuilder: (context, index) =>
                                      const Divider(),
                                      itemCount: 3),
                                  fallback: (context)=>Center(child: CircularProgressIndicator.adaptive(),),
                                )
                              ],
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
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Yearly users number analysis',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<_SalesData, String>>[
                                LineSeries<_SalesData, String>(
                                    dataSource: data,
                                    xValueMapper: (_SalesData views, _) =>
                                        views.year,
                                    yValueMapper: (_SalesData views, _) =>
                                        views.views,
                                    name: 'Users',
                                    // Enable data label
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true))
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
