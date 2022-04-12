import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/new/question_model.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key}) : super(key: key);

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
      create: (context) => QuizsCubit()..getAuthorQuestion(),
      child: BlocConsumer<QuizsCubit, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = QuizsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Questions',
                style: const TextStyle(color: primaryColor, fontSize: 25),
              ),
            ),
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.clickFloat) {
                  if (formKey.currentState!.validate()) {
                    cubit.createNewQuestion(
                        questionTitle: questionController.text,
                        answerIndex:
                            int.parse(correctAnswerController.text) - 1,
                        options: [
                          answer1Controller.text,
                          answer2Controller.text,
                          answer3Controller.text,
                          answer4Controller.text
                        ]);
                  } else {
                    cubit.changeCurrentIndex(false);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) {
                        return BlocConsumer<QuizsCubit, QuizStates>(
                          listener: (context, state) {
                            if (state is CreateQuestionSuccessState) {
                              navigatorAndRemove(context, QuestionScreen());
                            }
                          },
                          builder: (context, state) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                //   border: Border.all(color: primaryColor),
                                color: Colors.white10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        customTextFormFieldWidget(
                                            type: TextInputType.text,
                                            prefixIcon: Icons.quiz_sharp,
                                            prefix: true,
                                            label: "Question",
                                            controller: questionController,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'Question Must Be Not Empty';
                                              }
                                              return null;
                                            }),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            children: [
                                              customTextFormFieldWidget(
                                                  type: TextInputType.text,
                                                  prefixIcon: Icons.quiz_sharp,
                                                  prefix: true,
                                                  label: "Answer 1",
                                                  controller: answer1Controller,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Answer Must Be Not Empty';
                                                    }
                                                    return null;
                                                  }),
                                              customTextFormFieldWidget(
                                                  type: TextInputType.text,
                                                  prefixIcon: Icons.quiz_sharp,
                                                  prefix: true,
                                                  label: "Answer 2",
                                                  controller: answer2Controller,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Answer Must Be Not Empty';
                                                    }
                                                    return null;
                                                  }),
                                              customTextFormFieldWidget(
                                                  type: TextInputType.text,
                                                  prefixIcon: Icons.quiz_sharp,
                                                  prefix: true,
                                                  label: "Answer 3",
                                                  controller: answer3Controller,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Answer Must Be Not Empty';
                                                    }
                                                    return null;
                                                  }),
                                              customTextFormFieldWidget(
                                                  type: TextInputType.text,
                                                  prefixIcon: Icons.quiz_sharp,
                                                  prefix: true,
                                                  label: "Answer 4",
                                                  controller: answer4Controller,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Answer Must Be Not Empty';
                                                    }
                                                    return null;
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: customTextFormFieldWidget(
                                              type: TextInputType.number,
                                              prefixIcon:
                                                  Icons.numbers_outlined,
                                              prefix: true,
                                              label: "num correct answer",
                                              controller:
                                                  correctAnswerController,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Answer Must Be Not Empty';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ],
                                    ),
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
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.questionModel != null,
              builder: (context) => GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 1 / 0.75,
                children: List.generate(
                  cubit.questionModel!.questions!.length,
                  (index) => questionItem(context, index,
                      cubit.questionModel!.questions![index], cubit),
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

  Widget questionItem(context, index, Questions question, QuizsCubit cubit) {
    return Dismissible(
      // Show a red background as the item is swiped away.
      //   background: Container(color: Colors.red),
      key: UniqueKey(),
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
      ),
      // confirmDismiss: (direction) {
      //   return Future.value(direction == DismissDirection.horizontal);
      // },
      onDismissed: (direction) async {
        await cubit.deleteQuestion(
            id: cubit.questionModel!.questions![index].sId!);
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${cubit.questionModel!.questions![index].sId!} dismissed')));
      },
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
