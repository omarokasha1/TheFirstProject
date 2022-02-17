import 'package:flutter/material.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _SalesData {
  _SalesData(this.year, this.views);

  final String year;
  final double views;
}

class DashboardAuthorScreen extends StatelessWidget {
  DashboardAuthorScreen({Key? key}) : super(key: key);

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                                fontSize: 18,
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
                                  fontSize: 18,
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
                                  fontSize: 18,
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
                        footer: const Text(
                          "Rate completed assignment",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
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
                        footer: const Text(
                          "Rate completed assignment",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
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
                padding: const  EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),

                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),

                    // Chart title
                    title: ChartTitle(text: 'Half yearly courses views analysis'),
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
                              DataLabelSettings(isVisible: true))
                    ]),
              ),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                padding: const  EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [Text("data")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
