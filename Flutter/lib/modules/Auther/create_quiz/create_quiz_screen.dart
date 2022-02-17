import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/states.dart';
import 'package:lms/shared/component/constants.dart';

import '../../../shared/component/component.dart';
import 'cubit/cubit.dart';

class CreateQuizScreen extends StatelessWidget {
  CreateQuizScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var quistionController = TextEditingController();
  var correctAnswerController = TextEditingController();
  var answerOneController = TextEditingController();
  var answerTwoController = TextEditingController();
  var answerThreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: BlocConsumer<QuizCubit, QuizStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = QuizCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.clickFloat) {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    } else {
                      cubit.changeCurrentIndex(false);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet((context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              //   border: Border.all(color: primaryColor),
                              color: Colors.white10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    customTextFormFieldWidget(
                                        type: TextInputType.text,
                                        prefixIcon: Icons.quiz_sharp,
                                        prefix: true,
                                        label: "Quistion",
                                        controller: quistionController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'QuistionMust Be Not Empty';
                                          } else if (!cubit
                                              .hasQuistionName) {
                                            return 'please, enter a valid Quistion';
                                          }
                                          return null;
                                        }),
                                    customTextFormFieldWidget(
                                        type: TextInputType.text,
                                        prefixIcon: Icons.question_answer,
                                        prefix: true,
                                        label: "Correct Answer",
                                        controller: correctAnswerController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Correct Answer Must Be Not Empty';
                                          } else if (!cubit
                                              .hasQuistionName) {
                                            return 'please, enter a valid Correct Answer';
                                          }
                                          return null;
                                        }),
                                    customTextFormFieldWidget(
                                        type: TextInputType.text,
                                        prefixIcon:
                                        Icons.question_answer_outlined,
                                        prefix: true,
                                        label: "Answer One",
                                        controller: answerOneController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Answer One Must Be Not Empty';
                                          } else if (!cubit
                                              .hasQuistionName) {
                                            return 'please, enter a valid Answer One';
                                          }
                                          return null;
                                        }),
                                    customTextFormFieldWidget(
                                        type: TextInputType.text,
                                        prefixIcon:
                                        Icons.question_answer_outlined,
                                        prefix: true,
                                        label: "Answer Two",
                                        controller: answerTwoController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Answer Two Must Be Not Empty';
                                          } else if (!cubit
                                              .hasQuistionName) {
                                            return 'please, enter a valid Answer Two';
                                          }
                                          return null;
                                        }),
                                    customTextFormFieldWidget(
                                        type: TextInputType.text,
                                        prefixIcon:
                                        Icons.question_answer_outlined,
                                        prefix: true,
                                        label: "Answer Three",
                                        controller: answerThreeController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Answer Three Must Be Not Empty';
                                          } else if (!cubit
                                              .hasQuistionName) {
                                            return 'please, enter a valid Answer Three';
                                          }
                                          return null;
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                        .closed
                        .then((value) {
                      formKey.currentState!.reset();
                      cubit.changeCurrentIndex(false);
                    });
                  }
                  cubit.changeCurrentIndex(!(cubit.clickFloat));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) =>
                    GridView.count(
                      //   shrinkWrap: true,

                      crossAxisCount: 1,
                      childAspectRatio: 1 / 0.68,
                      children: List.generate(
                        20,
                            (index) => quistionItem(context, index),
                      ),
                    ),
                fallback: (context) =>
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.quiz_sharp,
                              color: Colors.grey[400],
                              size: 100,
                            ),
                            const Text(
                              "No Question Yet",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            );
          }),
    );
  }

  Widget quistionItem(context, index) {
    return Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Material(
            shadowColor: Colors.grey[300],
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Text("$index -" ,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 200,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Which language runs in a web browser",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        answerItem("A:","Java"),
                        answerItem("B:","C"),
                        answerItem("C:","Python"),
                        answerItem("D:","JavaScript"),

                      ],
                    ),
                  ),
                ),
              Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.edit),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return Future.value(direction == DismissDirection.horizontal);
      },
      onDismissed: (direction) {},
    );
  }
  Widget answerItem(String ch,String answer)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
         // color: Colors.grey[200],

          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Text(
                ch,

                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 15,),
              Text(
                answer,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}