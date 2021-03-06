import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/enroll_track.dart';
import 'package:lms/models/wishlist_courses.dart';
import 'package:lms/modules/my_learning/my_learning_cubit/cubit.dart';
import 'package:lms/modules/my_learning/my_learning_cubit/state.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class MyLearning extends StatelessWidget {
  MyLearning({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    Tab(text: 'Courses'),
    Tab(text: 'Tracks'),
    Tab(text: 'WishList'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyLearningCubit>(context)
        ..getAllWishlistData()
        ..getEnrollCourses()
        ..getEnrolledTracksData(),
      child: BlocConsumer<MyLearningCubit, MyLearningStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyLearningCubit.get(context);
          return Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'My Learning',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                  centerTitle: true,
                  backgroundColor: primaryColor,
                ),
                backgroundColor: primaryColor,
                body: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: primaryColor,
                        indicatorColor: primaryColor,
                        unselectedLabelColor: Colors.black,
                        isScrollable: true,
                        tabs: myTabs,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            //Courses
                            ConditionalBuilder(
                                condition: cubit.enrolledCourses != null,
                                builder: (context) {
                                  return cubit.enrolledCourses.length == 0
                                      ? emptyPage(
                                          text:
                                              'You Are not Enrolled in Any Course yet',
                                          context: context)
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          //NeverScrollableScrollPhysics:Creates scroll physics that does not let the user scroll.
                                          physics: BouncingScrollPhysics(),
                                          //repeated widget
                                          itemBuilder: (context, index) =>
                                              buildCourseItem(context, true,
                                                  cubit.enrolledCourses[index]),
                                          //number of repeats
                                          itemCount:
                                              cubit.enrolledCourses.length,
                                        );
                                },
                                fallback: (context) {
                                  return Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }),
                            //Tracks
                            ConditionalBuilder(
                              condition: cubit.enrollTracks != null,
                              builder: (context) {
                                return cubit.enrollTracks!.myTracks!.length != 0
                                    ? ListView.builder(
                                        //NeverScrollableScrollPhysics:Creates scroll physics that does not let the user scroll.
                                        physics: BouncingScrollPhysics(),
                                        //repeated widget
                                        itemBuilder: (context, index) =>
                                            builtTrackContant(
                                                context,
                                                cubit.enrollTracks!
                                                    .myTracks![index]),
                                        //number of repeats
                                        itemCount: cubit
                                            .enrollTracks!.myTracks!.length,
                                      )
                                    : emptyPage(
                                        text: "There's No Tracks you Enrolled",
                                        context: context);
                              },
                              fallback: (context) {
                                return Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              },
                            ),
                            //WishList
                            ConditionalBuilder(
                              condition: cubit.wishlistCourses != null,
                              builder: (context) {
                                return cubit.wishlistCourses!.wishList!
                                            .length ==
                                        0
                                    ? emptyPage(
                                        text: "There's No Wishlist added yet",
                                        context: context)
                                    : ListView.builder(
                                        //NeverScrollableScrollPhysics:Creates scroll physics that does not let the user scroll.
                                        physics: BouncingScrollPhysics(),
                                        //repeated widget
                                        itemBuilder: (context, index) =>
                                            buildCourseItem(
                                                context,
                                                false,
                                                cubit.wishlistCourses!
                                                    .wishList![index]),
                                        //number of repeats
                                        itemCount: cubit
                                            .wishlistCourses!.wishList!.length,
                                      );
                              },
                              fallback: (context) {
                                return Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              },
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
        },
      ),
    );
  }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lms/shared/component/component.dart';
// import 'package:lms/shared/component/constants.dart';
// import 'package:lms/shared/component/zoomDrawer.dart';
//
// class MyLearning extends StatefulWidget {
//   MyLearning({Key? key}) : super(key: key);
//
//   @override
//   _MyLearningState createState() => _MyLearningState();
// }
//
// class _MyLearningState extends State<MyLearning> with TickerProviderStateMixin {
//   late TabController _tabController;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         // app bar contains title and back icon
//         appBar: AppBar(
//           title: Text('My Learning',style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
//           iconTheme: IconThemeData(
//             color: Colors.white
//           ),
//           centerTitle: true,
//           backgroundColor: primaryColor,
//         ),
//         backgroundColor: primaryColor,
//         body: SingleChildScrollView(
//           // container for curves
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30)),
//             ),
//             //column contains tab bar and tab bar view.
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //tab bar to swipe between sections
//                 TabBar(
//                     controller: _tabController,
//                     isScrollable: true,
//                     labelColor: primaryColor,
//                     unselectedLabelColor: Colors.black,
//                     indicatorColor: primaryColor,
//                     //    labelPadding: EdgeInsets.only(left: 20, right: 20),
//                     //tabs names
//                     tabs: [
//                       Tab(text: 'Courses'),
//                       Tab(text: 'Tracks'),
//                       Tab(text: 'WishList'),
//                       Tab(text: 'Pending'),
//                       Tab(text: 'Archived'),
//                     ]),
//                 //this container contains tab bar view
//                 Container(
//                   color: Colors.grey[300],
//                   width: double.maxFinite,
//                   height: MediaQuery.of(context).size.height,
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       //tab view for first tab
//                       //ListView.builder:creates a scrollable, linear array of widgets
//                       ListView.builder(
//                         //NeverScrollableScrollPhysics:Creates scroll physics that does not let the user scroll.
//                         physics: const NeverScrollableScrollPhysics(),
//                         //repeated widget
//                         itemBuilder: (context, index) =>
//                             buildCoursItem(context, index),
//                         //number of repeats
//                         itemCount: 3,
//                       ),
//                       //tab view for second tab
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) =>
//                             builtTrackContant(context),
//                         itemCount: 3,
//                       ),
//                       //tab view for third tab
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) =>
//                             buildCoursItem(context, index),
//                         itemCount: 3,
//                       ),
//                       //tab view for fourth tab
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) =>
//                             buildCoursItem(context, index),
//                         itemCount: 3,
//                       ),
//                       //tab view for fifth tab
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) =>
//                             buildCoursItem(context, index),
//                         itemCount: 3,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// widget design of one course
  static Widget buildCourseItem(context, bool course, WishList courses) =>
      Container(
        child: Padding(
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
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('${courses.imageUrl}'
                              //'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg',
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
                        //'Complete Instagram Marketing Course',
                        '${courses.title}',
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
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              //'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                              '${courses.author!.imageUrl}',
                            ),
                            radius: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //author name
                          Text(
                            //'Created by Kelvin',
                            '${courses.author!.userName}',
                          ),
                          const Spacer(),
                          // number of videos
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              //'20 Videos',
                              '${courses.contents!.length} Modules',
                            ),
                          ),
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
        ),
      );

  Widget builtTrackContant(context, MyTracks track) => Padding(
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
                  '${track.imageUrl}',
                  //'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
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
                      '${track.trackName}',
                      //'Full Stack',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${track.courses!.length} Courses',
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
                          width: 220.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: grayText,
                          ),
                        ),
                        //container for uncompleted percentage
                        Container(
                          height: 8,
                          width: 140.w,
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

  Widget buildPendingItem(context, model) => Padding(
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
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            width: double.infinity,
                            child: const Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: primaryColor),
                            child: Text(
                              '20 Vides',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
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
                      style: TextStyle(fontSize: 16),
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
                        MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'Requested',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildArchived(context) => Padding(
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
                          width: 220.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: grayText,
                          ),
                        ),
                        //container for uncompleted percentage
                        Container(
                          height: 8,
                          width: 220.w,
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
                    Text('100% Complete')
                  ],
                ),
              ),
              //empty spacer that can be used to tune the spacing between widgets in rows
              Spacer(),
            ],
          ),
        ),
      );
}
