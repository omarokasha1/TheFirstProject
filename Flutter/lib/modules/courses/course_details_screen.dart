import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_screen.dart';
import 'package:lms/shared/component/constants.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constants.dart';

class CoursesDetailsScreen extends StatelessWidget {
  final Courses courseModel;
  CoursesDetailsScreen(this.courseModel,{Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Course Content'),
    const Tab(text: 'OverView'),
    const Tab(text: 'Assignments'),
    const Tab(text: 'Reviews'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Layout(
        widget: DefaultTabController(
          length: myTabs.length,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // course image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:
                      // Image.network(
                      //   //'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                      //   '${courseModel.imageUrl}',
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      imageFromNetwork(url: '${courseModel.imageUrl}',height: 200.h),
                    ),
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.grey,
                      size: 50,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${courseModel.title}',
                  style: Theme.of(context).textTheme.headline5,
                ),
               // defaultButton(onPressed: () {}, text: 'Add WatchList'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Created by ${courseModel.author!.userName}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        navigator(context,AuthorProfileScreen(courseModel.author!.sId!));
                      },
                      child: CircleAvatar(
                        backgroundImage:
                        CachedNetworkImageProvider(
                          '${courseModel.author!.imageUrl}',
                        ),
                        radius: 25,
                      ),
                    ),
                    //   NetworkImage(
                    //       'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                    //   radius: 24,
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('${courseModel.author!.userName}'),
                    const Spacer(),
                    //course rate
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor.withOpacity(0.7)),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children:  const [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Test Here",
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
                Container(

                  child: TabBar(
                      tabs: myTabs,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: primaryColor,
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      //tab name
                     ),
                ),

                //tab bar children
                Expanded(
                  child: TabBarView(
                    children: [
                      // tab bar Course Content
                      ListView.builder(

                        // stop scroll in list view and rely scroll on the column
                   //    physics: const NeverScrollableScrollPhysics(),

                        itemBuilder: (context, index) => builtCourseContent(courseModel.contents![index],context),
                        itemCount: courseModel.contents!.length,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            const Text(
                              'Description:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              //'Build your Career in Healthcare, Data Science, Web Development, Business, Marketing & More. Learn from anywhere, anytime. Flexible, 100% online learning. Join & get 7-day free trial. Online Certification. 150+ University Partners. Real-world Projects.',
                              "${courseModel.description}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => const SizedBox(),
                        itemCount: 3,
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => const SizedBox(),
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
// Widget include design course Content card
Widget builtCourseContent(Contents model,context) => InkWell(
  onTap: (){
   // navigator(context,ModuleDetailsScreen(model) );
  },
  child:   Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 120,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
             // 'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
              '${model.imageUrl}',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.contentTitle.toString()),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '${model.contentDuration}',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          const Spacer(),
          const CircleAvatar(
            backgroundColor: primaryColor,
            radius: 16,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  ),
);