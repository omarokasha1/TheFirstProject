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
    const Tab(text: 'Pending'),
    const Tab(text: 'Published'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     // value: BlocProvider.of<CreateTrackCubit>(context)..getAllTracks(),
      create: (BuildContext context)=> CreateTrackCubit()..getAllTracks()..getAuthorTrackPublishedData(),
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
                  condition: cubit.trackModel != null && cubit.trackModelPublished != null,
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
                                return pendingTracks(cubit);
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
                                return publishedTracks(cubit);
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
          return buildAuthorTrack(context, cubit.trackModelPublished!.tracks![index], cubit,false);
        },
        itemCount: cubit.trackModelPublished!.tracks!.length);
  }

  //Pending Courses PageView
  Widget pendingTracks(CreateTrackCubit cubit) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildAuthorTrack(context, cubit.trackModel!.tracks![index], cubit,true);
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
  Widget buildAuthorTrack(context, Tracks modelTrack, CreateTrackCubit cubit,bool request) {
    return InkWell(
      onTap: (){
        navigator(context, TracksDetailsScreen(modelTrack));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 110.h,
          padding: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                offset: Offset(0.6, 1.2), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    '${modelTrack.imageUrl}',
                    height: 150.h,
                    width: 140.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 4,
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
              Expanded(
                flex: 1,
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 30,
                    color: primaryColor,
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {
                            navigator(context, UpdateTrackScreen(modelTrack));
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit')),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {
                            print(modelTrack.sId!);
                            cubit.deleteTrack(trackId: modelTrack.sId!);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          )),
                      value: 2,
                    ),
                    if (request)
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: () {
                              cubit.sendTracksRequest(trackId: modelTrack.sId);
                              print(modelTrack.sId.toString());
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.green,
                            ),
                            label: const Text(
                              'Request',
                              style: TextStyle(color: Colors.green),
                            )),
                        value: 3,
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
