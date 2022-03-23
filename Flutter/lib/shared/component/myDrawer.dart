import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:lms/modules/home/home_screen.dart';
import 'package:lms/modules/manager/requests_screen.dart';
import 'package:lms/modules/my_learning/mylearning.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/profile_screen.dart';
import 'package:lms/modules/splash_screen.dart';
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
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          backgroundColor: primaryColor,
          // or drawer
          body: ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) => ListView(
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
                        //Switcher to User
                        if ((userView == 'author' && userType == 'author') ||
                            (userView == 'manager' && userType == 'manager') ||
                            (userView == 'author' && userType == 'manager') ||
                            (userView == 'admin' && userType == 'admin') ||
                            (userView == 'manager' && userType == 'admin') ||
                            (userView == 'author' && userType == 'admin'))
                          ListTile(
                            title: const Text(
                              "Switch To User",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.swap_horiz,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch User ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(
                                                    key: "userView",
                                                    value: "user");
                                                userType = CacheHelper.get(
                                                    key: 'userType');
                                                navigatorAndRemove(
                                                    context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
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
                                //   btnOkOnPress: () {},
                              ).show();
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        //Switcher to Author
                        if ((userView == 'user' && userType == 'author')||
                            (userView == 'manager' && userType == 'manager')||
                            (userView == 'user' && userType == 'manager')||
                            (userView == 'admin' && userType == 'admin')||
                            (userView == 'manager' && userType == 'admin')||
                            (userView == 'user' && userType == 'admin'))
                          ListTile(
                            title: const Text(
                              "Switch To Author",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.swap_horiz,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch Author ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(
                                                    key: "userView",
                                                    value: "author");
                                                userType = CacheHelper.get(
                                                    key: 'userType');
                                                navigatorAndRemove(
                                                    context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
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
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        //Switcher to Manager
                        if ((userView == 'author' && userType == 'manager')||
                            (userView == 'user' && userType == 'manager')||
                            (userView == 'admin' && userType == 'admin')||
                            (userView == 'author' && userType == 'admin')||
                            (userView == 'user' && userType == 'admin'))
                          ListTile(
                            title: const Text(
                              "Switch To Manager",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.swap_horiz,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch Manager ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(
                                                    key: "userView",
                                                    value: "manager");
                                                userType = CacheHelper.get(
                                                    key: 'userType');
                                                navigatorAndRemove(
                                                    context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
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
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        //Switcher to Admin
                        if ((userView == 'manager' && userType == 'admin')||
                            (userView == 'author' && userType == 'admin')||
                            (userView == 'user' && userType == 'admin'))
                          ListTile(
                            title: const Text(
                              "Switch To Admin",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.swap_horiz,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch Admin ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(
                                                    key: "userView",
                                                    value: "admin");
                                                userType = CacheHelper.get(
                                                    key: 'userType');
                                                navigatorAndRemove(
                                                    context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
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
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
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
                            navigator(
                                context,
                                ZoomDrawerScreen(
                                  widget: HomePage(),
                                ));
                            ZoomDrawer.of(context)!.toggle();
                          },
                        ),
                        if (userView == 'user')
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
                              navigator(
                                  context,
                                  ZoomDrawerScreen(
                                    widget: HomePage(),
                                  ));
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        if (userView == 'manager')
                          ListTile(
                            title: const Text(
                              "Author Requests",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.add,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              navigator(
                                  context,
                                  ZoomDrawerScreen(
                                    widget: AuthorRequest(),
                                  ));
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        if (userView == 'admin')
                          ListTile(
                            title: const Text(
                              "Add Manager",
                              style: TextStyle(
                                color: textColorDrawer,
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              Icons.add,
                              color: iconColorDrawer,
                              size: 25,
                            ),
                            onTap: () {
                              navigator(
                                  context,
                                  ZoomDrawerScreen(
                                    widget: AddManager(),
                                  ));
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        if (userView == 'author')
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
                              navigator(
                                  context,
                                  ZoomDrawerScreen(
                                    widget: DashboardAuthorScreen(),
                                  ));
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        if (userView == 'author')
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
                        if (userView == 'author')
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
                        if (userView == 'author')
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
                        if (userView == 'user')
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
                        if (userView == 'user')
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
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
