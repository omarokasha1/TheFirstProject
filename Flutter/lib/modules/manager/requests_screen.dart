import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/author_request.dart';
import 'package:lms/models/new/course_requests.dart';
import 'package:lms/models/new/track_requests.dart';
import 'package:lms/modules/manager/bloc/cubit.dart';
import 'package:lms/modules/manager/bloc/states.dart';
import 'package:lms/shared/component/component.dart';

import 'package:lms/shared/component/constants.dart';

class AuthorRequest extends StatelessWidget {
  AuthorRequest({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Author'),
    const Tab(text: 'Courses'),
    const Tab(text: 'Track'),
    //const Tab(text: 'Users'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManagerCubit, ManagerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ManagerCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Requests',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          body: Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Column(
                children: [
                  TabBar(
                    labelColor: primaryColor,
                    indicatorColor: primaryColor,
                    unselectedLabelColor: Colors.black,
                    tabs: myTabs,
                    labelStyle: const TextStyle(
                      //fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        //Author Requests
                        ConditionalBuilder(
                          condition: cubit.authorRequests != null,
                          builder: (context) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return cubit.authorRequests!.promotRequests!.isEmpty
                                      ? emptyPage(
                                          text: "No Author Requests yet",
                                          context: context)
                                      : acceptsAuthorCard(cubit.authorRequests!.promotRequests![index], cubit, context);
                                },
                                itemCount: cubit
                                    .authorRequests!.promotRequests!.length);
                          },
                          fallback: (context) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                        //Courses Requests
                        ConditionalBuilder(
                          condition: cubit.coursesRequests != null,
                          builder: (context) {
                            print(cubit
                                .coursesRequests!.courseRequests!.length);
                            return cubit.coursesRequests!.courseRequests!.isEmpty
                                ? emptyPage(
                                    text: "There's no Track request yet",
                                    context: context)
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        userCourseCard(
                                            cubit.coursesRequests!
                                                .courseRequests![index],
                                            cubit,
                                            context),
                                    itemCount: cubit.coursesRequests!
                                        .courseRequests!.length);
                          },
                          fallback: (context) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                        //Track Requests
                        ConditionalBuilder(
                          condition: cubit.trackRequestsModel != null,
                          builder: (context) {
                            return cubit.trackRequestsModel!.trackRequests!.isEmpty
                                ? emptyPage(
                                    text: "There's no Track request yet",
                                    context: context)
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        AuthorTrackCard(
                                            cubit.trackRequestsModel!
                                                .trackRequests![index],
                                            cubit,
                                            context),
                                    itemCount: cubit.trackRequestsModel!
                                        .trackRequests!.length);
                          },
                          fallback: (context) {
                            return Center(
                              child: const CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                        //User Request for Enrolled Course
                        // ConditionalBuilder(
                        //   condition: cubit.userModel != null,
                        //   builder: (context) {
                        //     return ListView.builder(
                        //         physics: const BouncingScrollPhysics(),
                        //         itemBuilder: (context, index) => userCard(
                        //             cubit.userModel!.users![index],
                        //             cubit,
                        //             context),
                        //         itemCount: cubit.userModel!.users!.length);
                        //   },
                        //   fallback: (context) {
                        //     return Center(
                        //       child: cubit.authorRequests != null &&
                        //               cubit.authorRequests!.promotRequests!
                        //                       .length ==
                        //                   0
                        //           ? emptyPage(
                        //               text: "There's No Request's",
                        //               context: context)
                        //           : const CircularProgressIndicator
                        //               .adaptive(),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget acceptsAuthorCard(
      PromotRequests promotRequests, ManagerCubit cubit, context) {
    return Padding(
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
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    promotRequests.authorPromoted!.imageUrl ??
                        'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                  ),
                  radius: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150.w,
                  child: Text(
                    '${promotRequests.authorPromoted!.userName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                                  'Are you sure you want ${promotRequests.authorPromoted!.userName} become an Author ?',
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
                                      cubit.updateUserProfile(
                                          userRequestId: promotRequests
                                              .authorPromoted!.sId);
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
                    'Accept',
                  ),
                ),
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
                                  'Are you sure you want remove request from ${promotRequests.authorPromoted!.userName} ?',
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
                                      cubit.deleteAuthorRequest(
                                          userRequestId: promotRequests
                                              .authorPromoted!.sId!);
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Course Widget
  Widget userCourseCard(CourseRequests model, ManagerCubit cubit, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(0),
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
                    model.courseId!.title ?? '',
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
                        backgroundImage: NetworkImage(
                          // 'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                          '${model.authorId!.imageUrl}',
                        ),
                        radius: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100.w,
                        child: Text(
                          '${model.authorId!.userName}',
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
                                          'Are you sure you want ${model.courseId!.title} course accept ?',
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
                                              cubit.acceptCourseRequest(
                                                  authorId: model.authorId!.sId,
                                                  courseId:
                                                      model.courseId!.sId);
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
                                          'Are you sure you want remove course request from ${model.courseId!.title} ?',
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
                                              cubit.deleteCourseRequestData(
                                                  courseId:
                                                      model.courseId!.sId!);
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
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AuthorTrackCard(TrackRequests model, ManagerCubit cubit, context) {
    return Padding(
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
                CircleAvatar(
                  backgroundImage: NetworkImage('${model.authorId!.imageUrl}'),
                  radius: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${model.authorId!.userName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${model.trackId!.trackName}',
                    style: const TextStyle(
                      // color: Colors.black,
                      //  fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
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
                                        'Are you sure you want ${model.trackId!.trackName} track accept ?',
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
                                                authorId: model.authorId!.sId,
                                                trackId: model.trackId!.sId);
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
                                      'Are you sure you want remove track request  ${model.trackId!.trackName} ?',
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
                                          cubit.deleteTrackRequestData(
                                              trackId: model.trackId!.sId!);
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
