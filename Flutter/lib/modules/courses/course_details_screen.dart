import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/course_model.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constants.dart';

class CoursesDetailsScreen extends StatefulWidget {
  final CourseModel courseModel;

  const CoursesDetailsScreen(this.courseModel, {Key? key}) : super(key: key);

  @override
  State<CoursesDetailsScreen> createState() =>
      _CoursesDetailsScreenState(this.courseModel);
}

class _CoursesDetailsScreenState extends State<CoursesDetailsScreen>
    with TickerProviderStateMixin {
  final CourseModel courseModel;

  _CoursesDetailsScreenState(this.courseModel);

  late TabController _tabController;
  @required
  // to navigate inside tabpar
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  late bool checkedValue =false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                            imageFromNetwork(
                                url: '${courseModel.imageUrl}', height: 200.h),
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
                  MaterialButton(
                    onPressed: () {},
                    child: const Text(
                      'Add to wishlist',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    minWidth: double.infinity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Created by',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          '${courseModel.author!.imageUrl}',
                        ),
                        radius: 25,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/star.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${courseModel.review}",
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
                ],
              ),
            ),
            Container(
              child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: primaryColor,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: primaryColor,
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  //tab name
                  tabs: const [
                    Tab(text: 'Course Content'),
                    Tab(text: 'OverView'),
                    Tab(text: 'Assignments'),
                    Tab(text: 'Reviews'),
                  ]),
            ),

            //tab bar children
            Container(
              // take full width
              width: double.maxFinite,
              // take full height
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // tab bar Course Content
                  ListView.builder(
                    // stop scroll in list view and rely scroll on the column
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => builtCourseContent(),
                    itemCount: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          //'Build your Career in Healthcare, Data Science, Web Development, Business, Marketing & More. Learn from anywhere, anytime. Flexible, 100% online learning. Join & get 7-day free trial. Online Certification. 150+ University Partners. Real-world Projects.',
                          "${courseModel.description}",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => SizedBox(),
                    itemCount: 3,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => SizedBox(),
                    itemCount: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget builtCourseContent() => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Checkbox(
              value: checkedValue,
              onChanged: (v) {
                setState(() {
                  checkedValue= v!;
                });
              },
             // controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          //image

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),

          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome To The Course Welcome To The Course',
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '10 Minutes',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 16,
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
  );

}

// Widget include design course Content card
