import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/authertication/login/login_screen.dart';
import 'package:lms/modules/authertication/register/register_cubit/cubit.dart';
import 'package:lms/modules/authertication/register/register_cubit/state.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/component.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            if(state.model.status=="ok")
              {
                navigatorAndRemove(
                  context,
                  LoginScreen(),
                );
              }
            else
              {
                showToast(message: "${state.model.message}",color: Colors.red);
              }

          }else if(state is RegisterErrorState){

            showToast(message: state.error,color: Colors.red);
          }

        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                            fit: BoxFit.fill)),
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
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.sp,
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
                                  onChanged: (name){
                                    cubit.onNameChanged(name);
                                  },
                                  controller: nameController,
                                  //error: "User Name Must Be Not Empty",
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'User Name Must Be Not Empty';
                                    }else if(!cubit.hasName){
                                      return 'please, enter a valid name';
                                    }
                                    return null;
                                  },
                                  label: "Enter your Name",
                                  type: TextInputType.text,
                                ),
                                customTextFormField(
                                  onChanged: (email)
                                  {
                                    cubit.onEmailChanged(email);
                                  },
                                  controller: emailController,
                                 // error: "Email Must Be Not Empty",
                                  validate:(value){
                                    if (value!.isEmpty) {
                                      return 'Email Must Be Not Empty ';
                                    }else if (!cubit.hasEmailValid)
                                    {
                                      return 'Please, Enter A valid email';
                                    }
                                    return null;
                                  },
                                  label: "Enter your Email",
                                  type: TextInputType.emailAddress,
                                ),
                                customTextFormField(
                                  onChanged: (password)
                                  {
                                    cubit.onPasswordChanged(password);
                                  },
                                  controller: passwordController,
                                 // error: "Password Must Be Not Empty",
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password Must Be Not Empty';
                                    }
                                    else if(!cubit.hasPasswordNumber){
                                      return 'Please, Enter A valid Password';
                                    }
                                    else if(!cubit.isPasswordCharacters){
                                      return 'please, Enter a 8 characters';
                                    }
                                    return null;
                                  },
                                  label: "Password",
                                  type: TextInputType.text,
                                  obSecure: cubit.eye ? true : false,
                                  suffix: true,
                                  suffixIcon: cubit.eye
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  onPressed: () {
                                    cubit.changeEye();
                                  },
                                ),
                                customTextFormField(
                                  onChanged: (p)
                                  {
                                    cubit.onPasswordChanged(p);
                                  },
                                  controller: confirmPassController,
                                 // error: "Confirm Password Must Not Be Empty",
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password Must Be Not Empty';
                                    }
                                    else if(passwordController.text != confirmPassController.text)
                                    {
                                      return 'Password does not match ';
                                    }
                                    return null;
                                  },
                                  label: "Confirm Password",
                                  type: TextInputType.text,
                                  obSecure: cubit.confirmEye ? true : false,
                                  suffix: true,
                                  suffixIcon: cubit.confirmEye
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  onPressed: () {
                                    cubit.changeConfirmEye();
                                  },
                                ),
                                customTextFormField(
                                  onChanged: (phone){
                                   cubit.onPhoneChange(phone);
                                  },
                                  controller: phoneController,
                                 // error: "Phone Must Be Not Empty",
                                  validate: (value) {
                                    if (value!.isEmpty ) {
                                      return 'Phone Must Be Not Empty';
                                    }else if(!cubit.hasPhonedNumber)
                                    {
                                      return 'phone number lass then 11';
                                    }
                                    return null;
                                  },
                                  label: "Enter your Phone",
                                  type: TextInputType.phone,
                                 // maxDigit: 11,
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
                                // print(nameController.text);
                                // print(emailController.text);
                                // print(passwordController.text);
                                // print(confirmPassController.text);
                                // print(phoneController.text);
                                if (passwordController.text !=
                                    confirmPassController.text) {
                                  showToast(
                                    message:
                                        "Conform Password Must be the Same",
                                    color: Colors.red,
                                  );
                                }
                                cubit.userRegister(
                                    userName: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: "Register"),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already Have Account ?",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
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
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
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
