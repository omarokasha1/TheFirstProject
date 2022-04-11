import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/new/track_requests.dart';
import 'package:lms/modules/admin/cubit/cubit.dart';
import 'package:lms/modules/admin/cubit/states.dart';
import 'package:lms/modules/manager/bloc/cubit.dart';
import 'package:lms/modules/manager/bloc/states.dart';
import 'package:lms/modules/manager/requests_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardManagerScreen extends StatelessWidget {
  const DashboardManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var aCubit = AdminCubit.get(context);
        return BlocConsumer<ManagerCubit, ManagerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ManagerCubit.get(context);
            return Scaffold(
              appBar: myAppBar(context),
              body: ConditionalBuilder(
                condition: aCubit.author != null &&
                    aCubit.trackNumber != null &&
                    cubit.trackRequestsModel != null,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
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
                                      // Text("${aCubit.author.length}"),
                                      Text(
                                        '${aCubit.author.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // NumberSlideAnimation(
                                      //   number: '${aCubit.author.length}',
                                      //   // number
                                      //   duration: const Duration(seconds: 4),
                                      //   //The time specified for the animation
                                      //   curve: Curves.fastOutSlowIn,
                                      //   //animation form
                                      //   textStyle: const TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
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
                                      Text(
                                        '${aCubit.trackNumber!.tracks!.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // NumberSlideAnimation(
                                      //   number:
                                      //       '${aCubit.trackNumber!.tracks!.length}',
                                      //   duration: const Duration(seconds: 4),
                                      //   curve: Curves.fastOutSlowIn,
                                      //   textStyle: const TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
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
                                      Text(
                                        '${cubit.totalRequests}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // NumberSlideAnimation(
                                      //   number: "${cubit.totalRequests}",
                                      //   duration: const Duration(seconds: 4),
                                      //   curve: Curves.fastOutSlowIn,
                                      //   textStyle: const TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 240.h,
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: CircularPercentIndicator(
                                  radius: 70.0.r,
                                  lineWidth: 14.0,
                                  animationDuration: 250,
                                  animation: true,
                                  percent: 0.7,
                                  center: const Text(
                                    "70.0%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  footer: Column(
                                    children: [
                                      const Text(
                                        "Tracks",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                      Text(
                                        "22 submitted",
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: double.infinity,
                                height: 240.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                // Package to display percentage inside a circle
                                child: Column(
                                  children: [
                                    const Text(
                                      'Top Author',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ConditionalBuilder(
                                      condition: aCubit.author.isNotEmpty ||
                                          aCubit.author.length >= 3,
                                      builder: (context) {
                                        return ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          '${aCubit.author[index].imageUrl}'),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            '${aCubit.author[index].userName}'),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        const Text(
                                                          '+12.8%',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                            itemCount: 3);
                                      },
                                      fallback: (context) {
                                        return Text("Top Author is Empty");
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   width: double.infinity,
                        //   padding: const EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: Colors.grey[100],
                        //   ),
                        //   child: Container(
                        //     width: double.infinity,
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           children: [
                        //             TextButton(
                        //                 onPressed: () {
                        //                   navigator(context, TracksScreen());
                        //                 },
                        //                 child: const Text("Views All ")),
                        //             const Spacer(),
                        //             MaterialButton(
                        //               onPressed: () {
                        //                 navigator(context, CreateTrackScreen());
                        //               },
                        //               child: const Text(
                        //                 'Add Tracks',
                        //                 style: TextStyle(color: Colors.white),
                        //               ),
                        //               color: primaryColor,
                        //             )
                        //           ],
                        //         ),
                        //         CarouselSlider(
                        //             options: CarouselOptions(
                        //               viewportFraction: 0.80,
                        //               enlargeCenterPage: true,
                        //               disableCenter: true,
                        //             ),
                        //             items: List.generate(
                        //                 5, (index) => builtTrackContant(context))),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Requests :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        navigator(context, AuthorRequest());
                                      },
                                      child: Row(
                                        children: const [
                                          Text(
                                            'View All',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ConditionalBuilder(
                                condition: cubit.trackRequestsModel!
                                    .trackRequests!.isNotEmpty,
                                builder: (context) => ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        authorTrackCard(
                                            cubit.trackRequestsModel!
                                                .trackRequests![index],
                                            context,
                                            cubit),
                                    itemCount: cubit.trackRequestsModel!
                                        .trackRequests!.length),
                                fallback: (context) => const Center(
                                    child: const Text('Requsets is empty')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
            );
          },
        );
      },
    );
  }
}

// Widget builtTrackContant(context) => Padding(
//       padding: const EdgeInsets.symmetric(vertical: 18.0),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//         ),
//         // row contains image of the track,name of the track,number of courses and completed percentage.
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //ClipRRect: widget that clips its child using a rounded rectangle
//             // show image of track
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image.network(
//                 'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
//                 width: 100.w,
//                 height: 100.h,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 110.w,
//                   child: Text(
//                     'Full Stack Full Stack Full Stack Full Stack',
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodyText1,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   '10 Courses',
//                   style: TextStyle(color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//             //empty spacer that can be used to tune the spacing between widgets in rows
//           ],
//         ),
//       ),
//     );

Widget authorTrackCard(TrackRequests trackModel, context, ManagerCubit cubit) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
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
                    Text(
                      '${trackModel.trackId!.trackName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('${trackModel.authorId!.imageUrl}'),
                          radius: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100.w,
                          child: Text(
                            '${trackModel.authorId!.userName}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.NO_HEADER,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      //  key: formkey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure you want ${trackModel.trackId!.trackName} Track accept ?',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                cubit.acceptTrackRequest(
                                                    authorId: trackModel
                                                        .authorId!.sId,
                                                    trackId: trackModel
                                                        .trackId!.sId);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'No',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                                //   btnOkOnPress: () {},
                              ).show();
                            },
                            child: const Text('Accept')),
                        TextButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.NO_HEADER,
                              body: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    //  key: formkey,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Are you sure you want remove track request  ${trackModel.trackId!.trackName} ?',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 40,
                                          child: defaultButton(
                                            text: 'Yes, I\'m Agree',
                                            onPressed: () {
                                              cubit.deleteTrackRequestData(context,
                                                  trackId:
                                                      trackModel.trackId!.sId!);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 40,
                                          child: defaultButton(
                                            text: 'No',
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                              //   btnOkOnPress: () {},
                            ).show();
                          },
                          child: const Text(
                            'Decline',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.green,) ,onPressed: (){}, child: Text("Accept"),),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.red, ) ,onPressed: (){}, child: const Text("Decline")),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        // SizedBox(height: 8.h,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
