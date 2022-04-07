import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/user_tracks/cubit/cubit.dart';
import 'package:lms/modules/user_tracks/cubit/states.dart';
import 'package:lms/modules/user_tracks/user_track_overview_screen.dart';
import 'package:lms/modules/user_tracks/user_trcks_enroll_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
class ViewAllTracksScreen extends StatelessWidget {
  List<Tracks?> model;
  ViewAllTracksScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackCubit,AllTracksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TrackCubit.get(context);
        return  Scaffold(
            appBar: AppBar(),
            body:ListView.builder(
                itemCount:model.length,
                itemBuilder: (context, index) => buildUserTrackItem(context, false,model[index]!))

        ) ;
      },
    );
  }
}

Widget buildUserTrackItem(context, bool enroll,Tracks model) =>
    InkWell(
      onTap: () {
        navigator(
            context,
            enroll
                ? UserTracksEnrollScreen(model)
                : UserTracksOverViewScreen(model));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
          height: 250.h,

          decoration: BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.6, 1.2), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: imageFromNetwork(
                          url:
                         // 'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg',),
                         '${model.imageUrl}'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12.0.w, right: 12.w, top: 5.h, bottom: 5.h),
                        margin: EdgeInsets.all(11.0.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '14 Courses',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     // 'Complete Instagram Marketing Course',
                     '${model.trackName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(

                           // 'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',),
                           '${model.author!.imageUrl}'),
                          radius: 16.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Created by : ${model.author!.userName} ',
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/star.png',width: 20,height: 20,),
                              SizedBox(
                                width: 5.w,
                              ),
                              //Text('${courseModel.review}'),
                              const Text('4.5',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

