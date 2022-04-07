import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms/modules/Auther/dashboard/dashboard_auther.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/create_quiz_screen.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/cubit/cubit.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class AuthorQuizScreen extends StatelessWidget {
  const AuthorQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: BlocConsumer<QuizCubit, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          'Quiz',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.QUESTION,
                              body: Form(
                                key: formKey,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        customTextFormFieldWidget(
                                            type: TextInputType.text,
                                            prefixIcon: Icons.drive_file_rename_outline,
                                            prefix: true,
                                            label: "Quiz Name",
                                            controller: quizController,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'Quiz Name Must Be Not Empty';
                                              }
                                              return null;
                                            }),
                                        Container(
                                          height: 40,
                                          child: defaultButton(
                                              text: 'OK',
                                              onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CreateQuizScreen(
                                                                  quizController.text)))
                                                      .then(
                                                        (value) {
                                                      quizController.text = "";
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',

                              // btnOkOnPress: () {
                              //   navigator(context, CreateQuizScreen());
                              // },
                            ).show();
                          },
                          child: Text(
                            'New Quiz',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildQuizItem(),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        shrinkWrap: true,
                        itemCount: 10,
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

  //Build ModuleItem
  Widget buildQuizItem() {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[100],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          SizedBox(width: 20.0,),
          Expanded(
            child: Text(
              "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 22.r,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 22.r,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}