import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/manager/requests_screen.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/modules/test/test.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _SalesData {
  _SalesData(this.year, this.views);

  final String year;
  final double views;
}

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45.h,
                      child: TextField(
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: const BorderSide(color: Colors.white),
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
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '5,000',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text('Users Today'),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                          SizedBox(
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
                          SizedBox(
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
                padding: EdgeInsets.all(20),
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
                                number: "8000",
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
                                number: "2234",
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
                                number: "15",
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
                    SizedBox(
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
                                number: "8000",
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
                                number: "2234",
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      // Package to display percentage inside a circle
                      child: Column(
                        children: [
                          Text(
                            'Active Users',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: const [
                                          Text('Name Name'),
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
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: 3)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      // Package to display percentage inside a circle
                      child: Column(
                        children: [
                          Text(
                            'Active Author',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text('Name Name'),
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
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: 3)
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
                    SizedBox(
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
                              xValueMapper: (_SalesData views, _) => views.year,
                              yValueMapper: (_SalesData views, _) =>
                                  views.views,
                              name: 'Users',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
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
