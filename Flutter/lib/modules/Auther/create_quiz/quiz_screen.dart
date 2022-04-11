import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_quiz/choose_questions.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/states.dart';

import '../../../models/new/quiz_model.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import 'cubit/cubit.dart';


class QuizeScreen extends StatelessWidget {
  QuizeScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var questionController = TextEditingController();
  var answer1Controller = TextEditingController();
  var answer2Controller = TextEditingController();
  var answer3Controller = TextEditingController();
  var answer4Controller = TextEditingController();
  var correctAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizsCubit()..getAuthorQuizes()
      ,
      child: BlocConsumer<QuizsCubit, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = QuizsCubit.get(context);
          return Scaffold(
            appBar:AppBar(
              title:const Text(
                'Quizes',
                style:  TextStyle(color: primaryColor, fontSize: 25),
              ),
            ),
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigator(context, ChooseQuestionsScreen());
                // if (cubit.clickFloat) {
                //   if (formKey.currentState!.validate()) {
                //     cubit.createNewQuiz(
                //         quizName: questionController.text,
                //         questions: [
                //           answer1Controller.text,
                //         ]
                //     );
                //   } else {
                //     cubit.changeCurrentIndex(false);
                //   }
                // } else {
                //   scaffoldKey.currentState!
                //       .showBottomSheet((context) {
                //     return BlocConsumer<QuizsCubit, QuizStates>(
                //       listener: (context, state) {
                //         if( cubit.questionModel != null){
                //           return print('loading ....');
                //         }
                //       },
                //       builder: (context, state) =>GridView.count(
                //         crossAxisCount: 1,
                //         childAspectRatio: 1 / 0.75,
                //         children: List.generate(
                //           cubit.questionModel!.questions!.length,
                //               (index) => questionItem(context, index,
                //               cubit.questionModel!),
                //         ),
                //       ),
                //       //     Padding(
                //       //   padding: const EdgeInsets.all(8.0),
                //       //   child: Container(
                //       //     decoration: const BoxDecoration(
                //       //       //   border: Border.all(color: primaryColor),
                //       //       color: Colors.white10,
                //       //     ),
                //       //     child: Padding(
                //       //       padding: const EdgeInsets.all(20.0),
                //       //       child: Form(
                //       //         key: formKey,
                //       //         child: SingleChildScrollView(
                //       //           child: Column(
                //       //             mainAxisSize: MainAxisSize.min,
                //       //             children: [
                //       //               customTextFormFieldWidget(
                //       //                   type: TextInputType.text,
                //       //                   prefixIcon: Icons.quiz_sharp,
                //       //                   prefix: true,
                //       //                   label: "Question",
                //       //                   controller: questionController,
                //       //                   validate: (value) {
                //       //                     if (value!.isEmpty) {
                //       //                       return 'Question Must Be Not Empty';
                //       //                     }
                //       //                     return null;
                //       //                   }),
                //       //               Padding(
                //       //                 padding:
                //       //                 const EdgeInsets.only(left: 8.0),
                //       //                 child: Column(
                //       //                   children: [
                //       //                     customTextFormFieldWidget(
                //       //                         type: TextInputType.text,
                //       //                         prefixIcon: Icons.quiz_sharp,
                //       //                         prefix: true,
                //       //                         label: "Answer 1",
                //       //                         controller: answer1Controller,
                //       //                         validate: (value) {
                //       //                           if (value!.isEmpty) {
                //       //                             return 'Answer Must Be Not Empty';
                //       //                           }
                //       //                           return null;
                //       //                         }),
                //       //                     customTextFormFieldWidget(
                //       //                         type: TextInputType.text,
                //       //                         prefixIcon: Icons.quiz_sharp,
                //       //                         prefix: true,
                //       //                         label: "Answer 2",
                //       //                         controller: answer2Controller,
                //       //                         validate: (value) {
                //       //                           if (value!.isEmpty) {
                //       //                             return 'Answer Must Be Not Empty';
                //       //                           }
                //       //                           return null;
                //       //                         }),
                //       //                     customTextFormFieldWidget(
                //       //                         type: TextInputType.text,
                //       //                         prefixIcon: Icons.quiz_sharp,
                //       //                         prefix: true,
                //       //                         label: "Answer 3",
                //       //                         controller: answer3Controller,
                //       //                         validate: (value) {
                //       //                           if (value!.isEmpty) {
                //       //                             return 'Answer Must Be Not Empty';
                //       //                           }
                //       //                           return null;
                //       //                         }),
                //       //                     customTextFormFieldWidget(
                //       //                         type: TextInputType.text,
                //       //                         prefixIcon: Icons.quiz_sharp,
                //       //                         prefix: true,
                //       //                         label: "Answer 4",
                //       //                         controller: answer4Controller,
                //       //                         validate: (value) {
                //       //                           if (value!.isEmpty) {
                //       //                             return 'Answer Must Be Not Empty';
                //       //                           }
                //       //                           return null;
                //       //                         }),
                //       //                   ],
                //       //                 ),
                //       //               ),
                //       //               Padding(
                //       //                 padding: const EdgeInsets.only(
                //       //                     top: 20.0,
                //       //                     left: 10,
                //       //                     right: 10,
                //       //                     bottom: 10),
                //       //                 child: customTextFormFieldWidget(
                //       //                     type: TextInputType.number,
                //       //                     prefixIcon:
                //       //                     Icons.numbers_outlined,
                //       //                     prefix: true,
                //       //                     label: "num correct answer",
                //       //                     controller:
                //       //                     correctAnswerController,
                //       //                     validate: (value) {
                //       //                       if (value!.isEmpty) {
                //       //                         return 'Answer Must Be Not Empty';
                //       //                       }
                //       //                       return null;
                //       //                     }),
                //       //               ),
                //       //             ],
                //       //           ),
                //       //         ),
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //     );
                //   })
                //       .closed
                //       .then((value) {
                //     formKey.currentState!.reset();
                //     cubit.changeCurrentIndex(false);
                //   });
                // }
                // cubit.changeCurrentIndex(!(cubit.clickFloat));
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.quizModel != null,
              builder: (context) => GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 1 / 0.60,
                children: List.generate(
                  cubit.quizModel!.quizes!.length,
                      (index) => quizItem(context, index,
                      cubit.quizModel!.quizes![index], cubit),
                ),
              ),
              fallback: (context) => Center(
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
        },
      ),
    );
  }

  Widget quizItem(context, index, Quizes quizes, QuizsCubit cubit) {
    return Dismissible(
      // Show a red background as the item is swiped away.
      //   background: Container(color: Colors.red),
      key: UniqueKey(),
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.only(top: 15.0),
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
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 25,
                  child: Text(
                    "${index + 1}-",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          quizes.quizName!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>  SizedBox(
                              width: double.infinity,
                              child: Text(
                               '${ quizes.questions![index].questionTitle}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            itemCount: quizes.questions!.length,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
      ),
      // confirmDismiss: (direction) {
      //   return Future.value(direction == DismissDirection.horizontal);
      // },
      onDismissed: (direction) async {
        await cubit.deleteQuiz(
            id: cubit.quizModel!.quizes![index].sId!);
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${cubit.questionModel!.questions![index].sId!} dismissed')));
      },
    );
  }



}
