import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_quiz/quiz_screen.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/states.dart';

import '../../../models/new/question_model.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';

class ChooseQuestionsScreen extends StatelessWidget {
  ChooseQuestionsScreen({Key? key}) : super(key: key);
  var quizController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizsCubit()..getAuthorQuestion(),
      child: BlocConsumer<QuizsCubit, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = QuizsCubit.get(context);
          // cubit.checked =
          //     List<bool>.filled(cubit.questionModel!.questions!.length, false);

          return Scaffold(
            appBar: AppBar(
                title: const Text(
              'My Questions',
              style: TextStyle(color: primaryColor, fontSize: 25),
            )),
            body: ConditionalBuilder(
              condition: cubit.questionModel != null,
              builder: (context) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextFormFieldWidget(
                            type: TextInputType.text,
                            prefixIcon: Icons.quiz_sharp,
                            prefix: true,
                            label: "Quiz Name",
                            controller: quizController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Quiz Must Be Not Empty';
                              }
                              return null;
                            }),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: 1 / 0.75,
                          children: List.generate(
                            cubit.questionModel!.questions!.length,
                            (index) => questionItem(context, index,
                                cubit.questionModel!.questions![index], cubit),
                          ),
                        ),
                      ),
                      defaultButton(
                          text: 'Add Quiz',
                          onPressed: () {
                            if (cubit.contentId.isEmpty &&
                                !formKey.currentState!.validate()) {
                              showToast(message: "Please choose questions");
                            } else {
                              cubit.createNewQuiz(
                                  quizName: quizController.text,
                                  questions: cubit.contentId);
                              showToast(message: "quiz created");

                              navigatorAndRemove(context, QuizeScreen());
                            }
                          }),
                    ],
                  ),
                );
              },
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

  Widget questionItem(context, index, Questions question, QuizsCubit cubit) {
    return InkWell(
      onTap: () {
        // if(cubit.contentId.isEmpty){
        //   cubit.contentId.add(question.sId!);
        // }
        cubit.contentId.add(question.sId!);
        showToast(message: "Question Added");

        print('${cubit.contentId}');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          margin: const EdgeInsets.symmetric(horizontal: 15),
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
                    child: Text(
                      "${index + 1}-",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            question.questionTitle!,
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
                              itemBuilder: (context, index) => answerItem(
                                "${index + 1}",
                                question.options![index],
                                question.answerIndex!,
                                index,
                              ),
                              itemCount: question.options!.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                // Checkbox(
                //     value: cubit.checked[index],
                //     onChanged: (value) {
                //       print('valueee $value / $index');
                //       cubit.changeCheckBox(value!, index);
                //       print('valueee $value / $index');
                //       print('${cubit.checked}');
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget answerItem(
      String ch, String answer, int correctAnswerIndex, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
            color: correctAnswerIndex == index ? primaryColor : null,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                ch,
                style: TextStyle(
                    fontSize: 20,
                    color: correctAnswerIndex == index ? Colors.white : null),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                answer,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    color: correctAnswerIndex == index ? Colors.white : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
