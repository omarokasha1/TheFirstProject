import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_cubit/cubit.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_module/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules_library/module_view.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/onboarding/onboarding_screen.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/splash_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/observer.dart';
import 'package:lms/shared/component/zoomDrawer.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';
import 'package:lms/shared/themes/light_theme.dart';
import 'package:native_notify/native_notify.dart';
import 'modules/Auther/dashboard/dashboard_auther.dart';
import 'modules/profile/profile_cubit/cubit.dart';
import 'shared/cubit For Internet/cubit.dart';

void main() async {
  //This to ensure that all Widget of Application is ready to run.
  WidgetsFlutterBinding.ensureInitialized();
  //This to set the Orientation of Screen portrait only.

  //This Code About Notification
  NativeNotify.initialize(84, 'sdaDWQPTDJjDtClGb1bEM7');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   setWindowMinSize(Size(375, 750));
  // }
  //Here we check the internet connectivity.
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connected = true;
    }
  } on SocketException catch (_) {
    connected = false;
  }
  //Initialize DioHelper and CashHelper to Run.
  await DioHelper.init();
  await CacheHelper.init();
  //We Cashed (Saved) that the user enter to onBoarding to not show again when he Enter  the Application.
  bool? onBoarding = CacheHelper.get(key: "onBoarding");
  //Here we make a widget that's be one of two ways if that user enter first time or he enter before
  Widget widget;
  if (onBoarding == null || onBoarding == false) {
    //Here User Enter the Application for the first time so we make widget = OnBoarding.
    widget = OnBoardingScreen();
  } else {
    //Here User Enter the Application Before so we mak widget = SplashScreen other Screens.
    widget = SplashScreen();
  }
  //Here The Initialize of Observer of Bloc that's show me in Run where i'm in the States of Cubit
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Build Multi Bloc Providers to listen them into project.
    return MultiBlocProvider(
      providers: [
        //Bloc of Internet Cubit.
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(create: (context) => QuizCubit()),
        //Bloc of Profile Cubit (Data of User).
        BlocProvider(create: (context) {
          if (userToken != null) {
            return ProfileCubit()..getUserProfile();
          }
          return ProfileCubit();
        }),
        //Bloc of Course Cubit.
        BlocProvider(create: (context) {
          if (userToken != null) {
            return CourseCubit()..getAllCoursesData();
          }
          return CourseCubit();
        }),
        BlocProvider(
            create: (context) => AuthorProfileCubit()..getAuthorProfile()),
        BlocProvider(create: (context) => CreateModuleCubit()),
        BlocProvider(create: (context) => CreateModuleCubit()),
        BlocProvider(create: (context)=> CreateAssignmentCubit()..getModulesData()..myActivities=[]),
        BlocProvider(create: (context)=> AuthorCoursesCubit()..getAuthorCoursesData()..getAuthorCoursesPublishedData()),
      ],
      //ScreenUTil is A Package make application responsive.
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          //This to Hide Debugger Banner in UI.
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          //Here The Theme.
          themeMode: ThemeMode.light,
          //home: Tracks(),
          //home:ZoomDrawerScreen(widget:DashboardAuthorScreen() ,) ,
          //home: ZoomDrawerScreen(widget: AuthorProfileScreen(),),
          // home:Layout(widget: ZoomDrawerScreen(widget:DashboardManagerScreen() ,)) ,
          //home: TracksScreen(),
          //home: widget,
           //home: ZoomDrawerScreen(widget:DashboardAuthorScreen() ,),
            home: widget,
           // home:Layout(widget: ZoomDrawerScreen(widget:ModuleDetailsScreen() ,)) ,
        ),
      ),
    );
  }
}
