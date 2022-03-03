import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lms/modules/Admin/add_manager.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_screen.dart';
import 'package:lms/modules/Auther/modules_library/modules_library.dart';
import 'package:lms/modules/Auther/traks/traks_screen.dart';
import 'package:lms/modules/authertication/change%20password/change_password_screen.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/modules/home_screen.dart';
import 'package:lms/modules/my_learning/mylearning.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/profile_screen.dart';
import 'package:lms/shared/component/zoomDrawer.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import '../../modules/Auther/dashboard/dashboard_auther.dart';
import 'component.dart';
import 'constants.dart';

// this is drawer widget
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
            backgroundColor: primaryColor,
            // or drawer
            body: ConditionalBuilder(
              condition: cubit.model!=null,
              builder: (context)=>ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 20, top: 20),
                    //user info (image-name-gmail)
                    child: UserAccountsDrawerHeader(
                      accountEmail: Text(
                        "${cubit.model!.profile!.email}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      accountName: Text(
                        "${cubit.model!.profile!.userName}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      currentAccountPicture: InkWell(
                        onTap: () {
                          navigator(context, ProfileScreen());
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xff067B85),
                          backgroundImage: CachedNetworkImageProvider(
                            //"https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg",
                            "${cubit.model!.profile!.imageUrl}",
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  //this is all items in drawer
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (!userAuthor)
                            ListTile(
                              title: const Text(
                                "Home",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.home,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, ZoomDrawerScreen(widget: HomePage(),));
                                ZoomDrawer.of(context)!.toggle();
                              },
                            ),
                          if (userAuthor)
                            ListTile(
                              title: const Text(
                                "Dashboard",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.home,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, ZoomDrawerScreen(widget: DashboardAuthorScreen(),));
                                ZoomDrawer.of(context)!.toggle();
                              },
                            ),
                          if (userAuthor)
                            ListTile(
                              title: const Text(
                                "Tracks",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.folder,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, TracksScreen());
                              },
                            ),
                          if (userAuthor)
                            ListTile(
                              title: const Text(
                                "Courses",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.play_circle_fill,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, AuthorCourses());
                              },
                            ),
                          if (userAuthor)
                            ListTile(
                              title: const Text(
                                "Modules",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.file_copy,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, ModulesLibraryScreen());
                              },
                            ),
                          if (!userAuthor)
                            ListTile(
                              title: const Text(
                                "Dashboard",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.dashboard,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {},
                            ),
                          if (!userAuthor)
                            ListTile(
                              title: const Text(
                                "My Learning",
                                style: TextStyle(
                                  color: textColorDrawer,
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                TablerIcons.table,
                                color: iconColorDrawer,
                                size: 25,
                              ),
                              onTap: () {
                                navigator(context, MyLearning());
                              },
                            ),
                          ListTile(
                            title: const Text(
                              "Change Password",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.lock,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              navigator(context, ChangePasswordScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  //log out button
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w, right: 100.w),
                    child: Container(
                      width: 50.w,
                      height: 40.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            CacheHelper.removeData(key: "token");
                            navigatorAndRemove(context, LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.exit_to_app,
                                color: primaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ),
        );
      },
    );
  }
}