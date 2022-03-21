import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/author_request.dart';
import 'package:lms/modules/manager/bloc/cubit.dart';
import 'package:lms/modules/manager/bloc/states.dart';
import 'package:lms/shared/component/component.dart';

import 'package:lms/shared/component/constants.dart';

class AuthorRequest extends StatelessWidget {
  AuthorRequest({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Accepts Author'),
    const Tab(text: 'Users'),
    const Tab(text: 'Courses & Track'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerCubit()..getAuthorRequests(),
      child: BlocConsumer<ManagerCubit, ManagerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ManagerCubit.get(context);
          return Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
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
                body: Column(
                  children: [
                    TabBar(
                      labelColor: primaryColor,
                      indicatorColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      tabs: myTabs,
                      labelStyle: TextStyle(
                        //fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ConditionalBuilder(
                            condition: cubit.authorRequests != null,
                            builder: (context) {
                              return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      acceptsAuthorCard(cubit.authorRequests!.promotRequests![index], cubit, context),
                                  itemCount: cubit.authorRequests!.promotRequests!.length);
                            },
                            fallback: (context) {
                              return Center(
                                child: cubit.authorRequests != null && cubit.authorRequests!.promotRequests!
                                    .length == 0 ? emptyPage(
                                    text: "There's No Request's",
                                    context: context): CircularProgressIndicator.adaptive(),
                              );
                            },
                          ),
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => userCourseCard(),
                              itemCount: 10),
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  AuthorTrackCard(),
                              itemCount: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget acceptsAuthorCard(PromotRequests promotRequests, ManagerCubit cubit, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
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
                SizedBox(
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
                Spacer(),
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
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 40,
                                  child: defaultButton(
                                    text: 'Yes, I\'m Agree',
                                    onPressed: () {
                                      cubit.updateUserProfile(userRequestId: promotRequests.authorPromoted!.sId);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
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
                  child: Text(
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
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 40,
                                  child: defaultButton(
                                    text: 'Yes, I\'m Agree',
                                    onPressed: () {
                                      cubit.deleteAuthorRequest(userRequestId: promotRequests.authorPromoted!.sId!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
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
                  child: Text(
                    'Decline',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            // Row(children: [
            //   // Text(
            //   //   'Web Development Full stack Track ',
            //   //   style: TextStyle(
            //   //    // color: Colors.black,
            //   //   //  fontSize: 17.sp,
            //   //     fontWeight: FontWeight.bold,
            //   //   ),
            //   //   overflow: TextOverflow.ellipsis,
            //   //   maxLines: 1,
            //   // ),
            //
            //      // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.green,) ,onPressed: (){}, child: Text("Accept"),),
            //   // SizedBox(
            //   //   width: 10.w,
            //   // ),
            //   // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.red, ) ,onPressed: (){}, child: const Text("Decline")),
            //   // SizedBox(
            //   //   width: 10.w,
            //   // ),
            //   // SizedBox(height: 8.h,),
            //
            // ],),
          ],
        ),
      ),
    );
  }
  //Course Widget
  Widget userCourseCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[100],
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
                    'Flutter Crash Course',
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
                            'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                        radius: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100.w,
                        child: Text(
                          'authorName authorName',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      TextButton(onPressed: () {}, child: Text('Accept')),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Decline',
                            style: TextStyle(color: Colors.red),
                          )),
                      // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.green,) ,onPressed: (){}, child: Text("Accept"),),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                      // ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.red, ) ,onPressed: (){}, child: const Text("Decline")),
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

  Widget AuthorTrackCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                  ),
                  radius: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Author Name ',
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
                Text(
                  'Web Development Full stack Track ',
                  style: TextStyle(
                    // color: Colors.black,
                    //  fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('Accept')),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Decline',
                      style: TextStyle(color: Colors.red),
                    )),
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
    );
  }
}
