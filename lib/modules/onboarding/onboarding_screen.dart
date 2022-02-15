import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/on_boarding_model.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/modules/authertication/register/register_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/on_boarding_item.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isList = false;
  // List Type of boarding model it contains the data of on boarding screen
  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'Welcome',
      lottie: 'https://assets2.lottiefiles.com/packages/lf20_uichdspt.json',
    ),
    BoardingModel(
      title: 'Hope You Enjoy With Us',
      lottie: 'https://assets5.lottiefiles.com/packages/lf20_nhgiwj0r.json',
    ),
    BoardingModel(
      title: 'Learning Process is Safe',
      lottie: 'https://assets9.lottiefiles.com/packages/lf20_nve3uwej.json',
    ),
    BoardingModel(
      title: 'We always with You',
      lottie: 'https://assets5.lottiefiles.com/packages/lf20_cdkfojwo.json',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Height to Screen Length
    var height = MediaQuery.of(context).size.height;
    // width to screen width
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Layout(
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: height > width ? 400.h : 200.w,
                  // Widget to display page onboarding
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    // The function of managing navigation between pageview
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isList = true;
                        });
                      } else {
                        setState(() {
                          isList = false;
                        });
                      }
                    },
                    // widget will be displayed in pageview
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index], context),
                    //number of displayed
                    itemCount: boarding.length,
                  ),
                ),
                // spacing
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // This package enables me to display point under pageview
                    SmoothPageIndicator(
                        controller: boardController,
                        effect: ExpandingDotsEffect(
                          activeDotColor: primaryColor,
                          dotColor: Colors.grey[400]!,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 8.0,
                        ),
                        count: boarding.length),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),

                // Create a horizontal line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // button object from defaultButton on component.dart file
                defaultButton(
                    onPressed: () {
                      CacheHelper.put(key: "onBoarding", value: true);

                      // navigator to login screen and remove this screen
                      navigatorAndRemove(context, LoginScreen());
                    },
                    text: 'Sign In'),
                const SizedBox(
                  height: 10.0,
                ),

                // button object from defaultButton on component.dart file
                defaultButton(
                  onPressed: () {
                    //
                    CacheHelper.put(key: "onBoarding", value: true);
                    // navigator to Register screen and remove this screen
                    // navigator object from navigatorAndRemove on component.dart file
                    navigatorAndRemove(context, RegisterScreen());
                  },
                  text: 'Sign Up',
                  color: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
