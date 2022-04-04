import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:readmore/readmore.dart';

class TracksDetailsScreen extends StatelessWidget {
  final Tracks track;
  const TracksDetailsScreen(this.track, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageFromNetwork(
                    url:
                        '${track.imageUrl}',
                   // fit: BoxFit.contain,
                    height: 180.h),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                '${track.trackName}',maxLines: 2,overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Track OverView :',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ReadMoreText(
                        '${track.description}',
                        trimLines: 3,
                        colorClickableText: Colors.black,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                        lessStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children:  [
                        const Text(
                          'Content',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Text(
                          '${track.courses!.length}  Courses',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => builtTrackContant(context,track.courses![index],),
                  itemCount: track.courses!.length),
            ],
          ),
        ),
      ),
    );
  }
}

Widget builtTrackContant(context,Courses course, ) {
  return InkWell(
    onTap: (){
      // navigator(context, CourseDetailsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "${course.imageUrl}",
                      // 'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                      width:double.infinity,
                      height: 100.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${course.title}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                      // Text(
                      //   'Create by : Name ',
                      //   style: TextStyle(
                      //     fontSize: 14.sp,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   maxLines: 1,
                      // ),
                      Text(
                        //'120 Video ',
                        '${course.contents!.length} Modules',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
