import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/authertication/login/login_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/edit_profile_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/zoomDrawer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
     var  cubit  = ProfileCubit.get(context);
        return Layout(
          widget: Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
             backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: (){
                navigatorAndRemove(context, ZoomDrawerScreen());
                },

              ),
            ),
            floatingActionButton: IconButton(
              iconSize: 50.0,
              onPressed: () {
                //print("button");
                navigator(context, EditProfileScreen());
              },
              icon: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 50.0.r,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              alignment: Alignment.bottomRight,
            ),
            body: ConditionalBuilder(
              condition: cubit.model!=null&&cubit.model!.profile !=null,

              builder:(context)=> Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 45.0,
                        backgroundImage: CachedNetworkImageProvider(
                          '${cubit.model!.profile!.imageUrl}',
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: CircleAvatar(
                            radius: 16.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 15.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                ),
                                color: Colors.white,
                                iconSize: 15.0,
                                onPressed: () {
                                  print("Pic");
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "${cubit.model!.profile!.userName}",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "${cubit.model!.profile!.bio}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.email}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Phone",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.phone}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.gender}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "City",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.city}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Country",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.country}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Birthday",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.birthDay}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Faculty",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.faculty}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "University",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.university}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Major",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.major}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Grade",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.grade}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Experience",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.experince}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "Interested",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.model!.profile!.userEducation!.interest!.join(" ")}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator(),),
            ),
          ),
        );
      },
    );
  }
}
