import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/search/search_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timelines/timelines.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        //
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 28.0.sp),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Lets schedule your courses',style: TextStyle(
                      color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 18.0.sp
                    ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: newVv,
              //     borderRadius: BorderRadius.circular(12)
              //   ),
              //   height: 220.h,
              //   child: Padding(
              //     padding: EdgeInsets.all(35.0.h),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Text(
              //                     "Hi, Name",
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w800,
              //                         fontSize: 28.0.sp)),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Image.asset(
              //                   'assets/images/hand.png',
              //                   width: 34.w,
              //                   height: 34.h,
              //                 )
              //               ],
              //             ),
              //             SizedBox(
              //               height: 8.h,
              //             ),
              //             Text(
              //               "Lets start learning!",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontFamily: 'Poppins',
              //                   fontSize: 25.0.sp),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 20.h,
              //         ),
              //         SizedBox(
              //           width: double.infinity,
              //           height: 45.h,
              //           child: TextField(
              //             cursorColor: primaryColor,
              //             decoration: InputDecoration(
              //               fillColor: Colors.white,
              //               filled: true,
              //               border: OutlineInputBorder(
              //                 borderRadius:
              //                 BorderRadius.circular(18.r),
              //                 borderSide: const BorderSide(
              //                     color: Colors.white),
              //               ),
              //               focusedBorder: OutlineInputBorder(
              //                 borderRadius:
              //                 BorderRadius.circular(18.r),
              //                 borderSide: const BorderSide(
              //                     color: secondaryColor),
              //               ),
              //               enabledBorder: OutlineInputBorder(
              //                 borderRadius:
              //                 BorderRadius.circular(18.r),
              //                 borderSide: const BorderSide(
              //                     color: Colors.white),
              //               ),
              //               hintText: "Search Courses",
              //               prefixIcon: const Icon(Icons.search),
              //             ),
              //             onTap: () {
              //               navigator(context, SearchScreen());
              //             },
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FixedTimeline.tileBuilder(
                          direction: Axis.horizontal,
                          builder: TimelineTileBuilder.connectedFromStyle(
                            contentsAlign: ContentsAlign.alternating,
                            oppositeContentsBuilder: (context, index) =>
                                const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('anyname'),
                            ),
                            contentsBuilder: (context, index) =>
                                const CircleAvatar(
                              backgroundColor: Color(0xff067B85),
                              backgroundImage: CachedNetworkImageProvider(
                                  "https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg"),
                            ),
                            connectorStyleBuilder: (context, index) =>
                                ConnectorStyle.solidLine,
                            indicatorStyleBuilder: (context, index) =>
                                IndicatorStyle.dot,
                            itemCount: 4,
                          ),
                        ),
                        LottieBuilder.network(
                          'https://assets8.lottiefiles.com/packages/lf20_qtt2dv.json',
                          width: 60.w,
                          height: 60.h,
                        ),
                      ],
                    ),
                  )),
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
                  SizedBox(
                    width: 10,
                  ),
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
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('progress',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                              children: [
                                const Text(
                                    'Courses name Courses name Courses name'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 7.0,
                                        percent: 0.9,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: primaryColor,
                                      ),
                                    ),
                                    const Text(
                                      "90.0%",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: 4),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [
                    const Text('Your Courses',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1 / 0.5,
                      padding: const EdgeInsets.all(10),
                      children: List.generate(
                        4,
                        (index) => Container(
                          padding: EdgeInsets.all(20),
                          width: double.minPositive,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor,
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                  child: Text(
                                'Courses names Courses',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: const [
                    Text('Your Assignment',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
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
