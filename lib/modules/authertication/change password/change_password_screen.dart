import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChangePasswordScreen extends StatelessWidget {
  var currentPasswordController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            showToast(
                message: "${state.changePassword.message}",
                color: primaryColor);
          } else if (state is ChangePasswordErrorState) {
            showToast(
                message: "Your Current Password Failed", color: Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = ChangePasswordCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Layout(
              widget: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                            painter: HeaderCurvedContainer(),
                          ),
                          Positioned(
                            top: 100,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                  child: Text(
                                "  Change \n Password",
                                style: TextStyle(
                                    fontSize: 30,
                                    letterSpacing: 1.5,
                                    color: primaryColor,
                                    fontFamily: "FONT1",
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0.w),
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
                                  customTextFormField(
                                    controller: currentPasswordController,
                                   // error: "Password Must Be Not Empty",
                                    validate:(value){
                                      if (value!.isEmpty || !cubit.hasEmailValid) {
                                        return 'Email Must Be Not Empty ';
                                      }
                                      return null;
                                    },
                                    label: "Old Password",
                                    type: TextInputType.text,
                                    obSecure: cubit.eye1 ? true : false,
                                    suffix: true,
                                    suffixIcon: cubit.eye1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed: () {
                                      cubit.changeEye1();
                                    },
                                  ),
                                  customTextFormField(
                                    controller: passwordController,
                                    //error: "Password Must Be Not Empty",
                                    validate: (value) {
                                      if (value!.isEmpty || !cubit.hasPasswordNumber || !cubit.isPasswordCharacters) {
                                        return 'Password Must Be Not Empty';
                                      }
                                      return null;
                                    },
                                    label: "New Password",
                                    type: TextInputType.text,
                                    obSecure: cubit.eye2 ? true : false,
                                    suffix: true,
                                    suffixIcon: cubit.eye2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed: () {
                                      cubit.changeEye2();
                                    },
                                  ),
                                  customTextFormField(
                                    controller: confirmPassController,
                                    //error: "Confirm Password Must Not Be Empty",
                                    validate: (value) {
                                      if (value!.isEmpty || !cubit.hasPasswordNumber || !cubit.isPasswordCharacters) {
                                        return 'Password Must Be Not Empty';
                                      }
                                      return null;
                                    },
                                    label: "Confirm new Password",
                                    type: TextInputType.text,
                                    obSecure: cubit.eye3 ? true : false,
                                    suffix: true,
                                    suffixIcon: cubit.eye3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed: () {
                                      cubit.changeEye3();
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text !=
                                      confirmPassController.text) {
                                    showToast(
                                      message:
                                          "Conform Password Must be the Same",
                                      color: Colors.red,
                                    );
                                  }
                                }
                              },
                              text: "Chane Password"),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = primaryColor;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
