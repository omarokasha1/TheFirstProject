import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/traks/create_track/Update_track.dart';
import 'package:lms/modules/Auther/traks/create_track/create_track.dart';
import 'package:lms/modules/Auther/traks/create_track/cubit/cubit.dart';
import 'package:lms/modules/Auther/traks/create_track/cubit/statues.dart';
import 'package:lms/modules/Auther/traks/tracks_details_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class TracksScreen extends StatelessWidget {
  TracksScreen({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    //Tab(text: 'Drafts'),
    const Tab(text: 'Published'),
    const Tab(text: 'Pendding'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     // value: BlocProvider.of<CreateTrackCubit>(context)..getAllTracks(),
      create: (BuildContext context)=> CreateTrackCubit()..getAllTracks(),
      child: BlocConsumer<CreateTrackCubit, CreateTrackStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CreateTrackCubit.get(context);
          return Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: AppBar(),
                body: ConditionalBuilder(
                  condition: cubit.trackModel != null ,
                  builder: (context) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'Tracks',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                //navigator(context, CreateTrackScreen());
                                Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                CreateTrackScreen())).then((value) {});
                              },
                              child: Text(
                                'New Track',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        labelColor: primaryColor,
                        indicatorColor: primaryColor,
                        unselectedLabelColor: Colors.black,
                        // isScrollable: true,
                        tabs: myTabs,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ConditionalBuilder(
                              condition: cubit.trackModel!.tracks! != 0,
                              builder: (context) {
                                return publishedTracks(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),
                            ConditionalBuilder(
                              condition: cubit.trackModel!.tracks! != 0,
                              builder: (context) {
                                return pendingTracks(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),
                            // ConditionalBuilder(
                            //   condition: cubit.trackModel!.tracks!.length != 0,
                            //   builder: (context) {
                            //     return draftsCourses(cubit);
                            //   },
                            //   fallback: (context) {
                            //     return emptyPage(
                            //         text: "No Tracks Added Yet",
                            //         context: context);
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  fallback: (context) => const Center(
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Published Courses PageView
  Widget publishedTracks(CreateTrackCubit cubit) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildAuthorCourse(context, cubit.trackModel!.tracks![index], cubit,false);
        },
        itemCount: cubit.trackModel!.tracks!.length);
  }

  //Pending Courses PageView
  Widget pendingTracks(CreateTrackCubit cubit) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildAuthorCourse(context, cubit.trackModel!.tracks![index], cubit,true);
        },
        itemCount: cubit.trackModel!.tracks!.length);
  }

  //Drafts Courses PageView
  // Widget draftsCourses(CreateTrackCubit cubit) {
  //   return ListView.builder(
  //       physics: BouncingScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         return BuildAuthorCourse(context, cubit.trackModel!.tracks![index], cubit);
  //       },
  //       itemCount: cubit.trackModel!.tracks!.length);
  // }

  //Course Widget
  Widget BuildAuthorCourse(context, Tracks modelTrack, CreateTrackCubit cubit,bool request) {
    return InkWell(
      onTap: (){
        navigator(context, TracksDetailsScreen(modelTrack));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120.h,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.grey[100],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              // Container(
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30.0),
              //     color: Colors.white,
              //   ),
              //   child: Image.network(
              //     'https://media.gettyimages.com/vectors/-vector-id960988454',
              //     height: 150.h,
              //     width: 140.w,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  //'https://media.gettyimages.com/vectors/-vector-id960988454',
                  '${modelTrack.imageUrl}',
                  height: 150.h,
                  width: 140.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Text(
                        //'Track Name',
                        '${modelTrack.trackName}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 18.r,
                          child: IconButton(
                            onPressed: () {
                              navigator(context, UpdateTrackScreen(modelTrack));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 18.r,
                          child: IconButton(
                            onPressed: () {
                              print(modelTrack.sId!);
                              cubit.deleteTrack(trackId: modelTrack.sId!);
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        if(request)
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent[400],
                          radius: 18.r,
                          child: IconButton(
                            onPressed: () {
                              cubit.sendTracksRequest(trackId: modelTrack.sId);
                              print(modelTrack.sId.toString());
                            },
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
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
