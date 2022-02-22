import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/traks/traks_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardManagerScreen extends StatelessWidget {
  const DashboardManagerScreen({Key? key}) : super(key: key);

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
                            'Total Author:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          // package to add animation to numbers

                          NumberSlideAnimation(
                            number: "300",
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
                          const Text('Total Tracks',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                          NumberSlideAnimation(
                            number: "10",
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
                          const Text('Requests:',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                          NumberSlideAnimation(
                            number: "25",
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 210.h,
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100]),
                      child: CircularPercentIndicator(
                        radius: 80.0.r,
                        lineWidth: 18.0,
                        animationDuration: 250,
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
                              "Tracks",
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      height: 210.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100]),
                      // Package to display percentage inside a circle
                      child: Column(
                        children: [
                          Text(
                            'Top Author',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.separated(
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
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                navigator(context, TracksScreen());
                              },
                              child: const Text("Views All ")),
                          Spacer(),
                          MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Add Tracks',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: primaryColor,
                          )
                        ],
                      ),
                      CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.80,
                            enlargeCenterPage: true,
                            disableCenter: true,
                          ),
                          items: List.generate(
                              5, (index) => builtTrackContant(context))),
                    ],
                  ),
                ),


              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [
                    const Text('Requests',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    SizedBox(height: 15,),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemBuilder: (context, index) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row (
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                            ),
                            SizedBox(width: 18,),
                            Text('Youssef',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            Text('Course Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

                            Spacer(),
                            TextButton(onPressed: (){}, child: Text('Accepts'))
                          ],
                        ),
                      ),itemCount: 3, ),
                    Column(
                      children: [
                        const Text('Users',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 15,),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemBuilder: (context, index) => Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row (
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                                ),
                                SizedBox(width: 18,),
                                Text('Youssef',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(width: 20,),
                                Text('Course Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

                                Spacer(),
                                TextButton(onPressed: (){}, child: Text('Accepts'))
                              ],
                            ),
                          ),itemCount: 3, )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget builtTrackContant(context) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        // row contains image of the track,name of the track,number of courses and completed percentage.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //ClipRRect: widget that clips its child using a rounded rectangle
            // show image of track
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Full Stack',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '10 Courses',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                SizedBox(
                  height: 10,
                ),
                // stack contains two containers and text
                // Stack(
                //   children: [
                //     //container for completed percentage
                //     Container(
                //       height: 8,
                //       width: 160.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(40),
                //         color: grayText,
                //       ),
                //     ),
                //     //container for uncompleted percentage
                //     Container(
                //       height: 8,
                //       width: 90.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(40),
                //         color: primaryColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // // text of completed percentage
                // Text('60% Complete')
              ],
            ),
            //empty spacer that can be used to tune the spacing between widgets in rows
          ],
        ),
      ),
    );
