import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

class MyLearning extends StatefulWidget {
  MyLearning({Key? key}) : super(key: key);

  @override
  _MyLearningState createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    //TabController: Coordinates tab selection between a TabBar and a TabBarView.
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // app bar contains title and back icon
        appBar: AppBar(
          title: Text('My Learning',style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          leading: IconButton(onPressed: (){
            //when click on icon navigate to user home screen
            navigatorAndRemove(context, ZoomDrawerScreen());
          }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          // container for curves
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
            ),
            //column contains tab bar and tab bar view.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //tab bar to swipe between sections
                TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: primaryColor,
                    //    labelPadding: EdgeInsets.only(left: 20, right: 20),
                    //tabs names
                    tabs: [
                      Tab(text: 'Courses'),
                      Tab(text: 'Tracks'),
                      Tab(text: 'WishList'),
                      Tab(text: 'Pending'),
                      Tab(text: 'Archived'),
                    ]),
                //this container contains tab bar view
                Container(
                  color: Colors.grey[300],
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //tab view for first tab
                      //ListView.builder:creates a scrollable, linear array of widgets
                      ListView.builder(
                        //NeverScrollableScrollPhysics:Creates scroll physics that does not let the user scroll.
                        physics: const NeverScrollableScrollPhysics(),
                        //repeated widget
                        itemBuilder: (context, index) =>
                            buildCoursItem(context, index),
                        //number of repeats
                        itemCount: 3,
                      ),
                      //tab view for second tab
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            builtTrackContant(context),
                        itemCount: 3,
                      ),
                      //tab view for third tab
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCoursItem(context, index),
                        itemCount: 3,
                      ),
                      //tab view for fourth tab
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCoursItem(context, index),
                        itemCount: 3,
                      ),
                      //tab view for fifth tab
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCoursItem(context, index),
                        itemCount: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// widget design of one course
Widget buildCoursItem(context, model) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: MediaQuery.of(context).size.width / 1.2,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    //column contains stack and column
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //stack contains image of the course and clip
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //take same decoration of image
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name of course
              Text(
                'Complete Instagram Marketing Course',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 14),
              //row contains name of author,image of author and number of videos
              Row(
                children: [
                  // author image
                  //CircleAvatar:is circle in which we can add background image.
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                    radius: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //author name
                  const Text('Created by Kelvin'),
                  const Spacer(),
                  // number of videos
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('20 Vides ')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // stack contains two containers and text
              Stack(
                children: [
                  //container for completed percentage
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: grayText,
                    ),
                  ),
                  //container for uncompleted percentage
                  Container(
                    height: 8,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('60% Complete')
            ],
          ),
        ),
      ],
    ),
  ),
);
// widget design of one track
// Widget buildTrackItem(context) => InkWell(
//       onTap: () {},
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         // Container hold all the design of track
//         child: Container(
//           width: MediaQuery.of(context).size.width / 1.2,
//           height: 300,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           //column contains stack and padding
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // stack contains image of the track and
//               Stack(
//                 alignment: AlignmentDirectional.bottomStart,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       width: MediaQuery.of(context).size.width / 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Image(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(
//                           'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
//                 //column contains name of track , number of courses and percentage of finishing
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //row contains track name and number of courses
//                     Row(
//                       children: [
//                         Text(
//                           'Full Stack',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyText1,
//                         ),
//                         //spacer to write number of courses in the end of row
//                         const Spacer(),
//                         Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Text('4 Courses ')),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // stack contains two containers and text
//                     Stack(
//                       children: [
//                         //container for completed percentage
//                         Container(
//                           height: 8,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: grayText,
//                           ),
//                         ),
//                         //container for uncompleted percentage
//                         Container(
//                           height: 8,
//                           width: 180,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // text of completed percentage
//                     Text('60% Complete')
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

// widget design of one track

// widget design of one track
Widget builtTrackContant(context) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 120,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              //column contains name of track, number of courses and percentages of completed.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Stack(
                    children: [
                      //container for completed percentage
                      Container(
                        height: 8,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: grayText,
                        ),
                      ),
                     //container for uncompleted percentage
                      Container(
                        height: 8,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // text of completed percentage
                  Text('60% Complete')
                ],
              ),
            ),
            //empty spacer that can be used to tune the spacing between widgets in rows
            Spacer(),
          ],
        ),
      ),
    );
