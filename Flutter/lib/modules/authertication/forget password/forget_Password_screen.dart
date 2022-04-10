import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/authertication/login/login_cubit/cubit.dart';
import 'package:lms/modules/authertication/login/login_cubit/state.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/component.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          //Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 350.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/background-Recovered.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 18.w,
                          width: 70.w,
                          height: 200.h,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 90.w,
                          width: 80.w,
                          height: 150.h,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 30.w,
                          top: 30.h,
                          width: 80.w,
                          height: 140.h,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 50.h),
                            child: Center(
                              child: Text(
                                "Forget Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0.w),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColor,
                                  blurRadius: 20.0.r,
                                  offset: Offset(0.w, 10.h),
                                ),
                              ],
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  customTextFormFieldAuth(
                                    state: TextInputAction.done,
                                    controller: emailController,
                                   // error: "Email Must Be Not Empty",
                                    label: "Enter your Email",
                                    validate:(value){
                                      if (value!.isEmpty || !cubit.hasEmailValid) {
                                        return 'Email Must Be Not Empty ';
                                      }
                                      return null;
                                    },
                                    type: TextInputType.emailAddress,
                                  ),
                                  // customTextFormField(
                                  //   controller: passwordController,
                                  //   error: "Password Must Be Not Empty",
                                  //   label: "Password",
                                  //   type: TextInputType.text,
                                  //   obSecure: cubit.eye ? true : false,
                                  //   suffix: true,
                                  //   suffixIcon: cubit.eye
                                  //       ? Icons.visibility
                                  //       : Icons.visibility_off,
                                  //   onPressed: () {
                                  //     cubit.changeEye();
                                  //   },
                                  // ),
                                  // SizedBox(
                                  //   height: 3.h,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          defaultButton(
                              text: 'Reset Password',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // print(emailController.text);
                                  // print(passwordController.text);
                                  // cubit.userLogin(
                                  //     email: emailcontroller.text,
                                  //     password: passwordcontroller.text);
                                  // navigatorAndRemove(
                                  //   context,
                                  //   const ZoomDrawerScreen(),
                                  // );
                                }
                              }),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              TextButton(
                                onPressed: () {
                                  navigatorAndRemove(
                                    context,
                                    LoginScreen(),
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 30.h,
                          // ),
                          // TextButton(
                          //   onPressed: () {
                          //     cubit.changeLoginState(2);
                          //   },
                          //   child: const Text(
                          //     "Forgot Password?",
                          //     style: TextStyle(
                          //       color: primaryColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
