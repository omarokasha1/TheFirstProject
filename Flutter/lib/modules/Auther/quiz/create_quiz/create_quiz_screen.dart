import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/Questions.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'cubit/cubit.dart';

class CreateQuizScreen extends StatelessWidget {
  final String quizName;

  CreateQuizScreen(this.quizName, {Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var quistionController = TextEditingController();

  int answerItems = 0;
  List controllerList = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: BlocConsumer<QuizCubit, QuizStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = QuizCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  quizName,
                  style: const TextStyle(color: primaryColor, fontSize: 25),
                ),
              ),
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.clickFloat) {
                    if (formKey.currentState!.validate()) {
                      if (cubit.val != -1) {
                        if (controllerList.length >= 2) {
                          cubit.addItemInList(
                            Question(
                              id: questionNumber,
                              question: quistionController.text,
                              answer: cubit.val,
                              options: [
                                for (TextEditingController j in controllerList)
                                  j.text
                              ],
                            ),
                          );

                          cubit.getItemInList(cubit.questions);
                          questionNumber++;
                          answerItems = 0;
                          controllerList.clear();
                          formKey.currentState!.reset();
                          cubit.val = -1;
                          Navigator.pop(context);
                          print(cubit.questions[0].options[1].toString());
                          quistionController.clear();
                        } else {
                          showToast(message: "please add at least two answer");
                        }
                      } else {
                        showToast(message: "Must choose the correct answer");
                      }
                    } else {
                      cubit.changeCurrentIndex(false);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet((context) {
                          return BlocConsumer<QuizCubit, QuizStates>(
                            listener: (context, state) {},
                            builder: (context, state) => Padding(
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
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          customTextFormFieldWidget(
                                              type: TextInputType.text,
                                              onChanged: (courseName) {
                                                cubit.onCourseNameChanged(
                                                    courseName);
                                              },
                                              prefixIcon: Icons.quiz_sharp,
                                              prefix: true,
                                              label: "Quistion",
                                              controller: quistionController,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Quistion Must Be Not Empty';
                                                } else if (!cubit
                                                    .hasQuistionName) {
                                                  return 'please, enter a valid Quistion';
                                                }
                                                return null;
                                              }),
                                          Container(
                                            height: 300,
                                            child: ListView.builder(
                                              itemCount: controllerList.length,
                                              physics: BouncingScrollPhysics(),
                                              // shrinkWrap: true,
                                              //   physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  answer(
                                                index: index,
                                                onChange: (value) {
                                                  print(value);
                                                  cubit.selectCorrectAnswer(
                                                      value);
                                                },
                                                val: cubit.val,
                                                controller:
                                                    controllerList[index],
                                                label: "Answer ${index + 1}",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: defaultButton(
                                                text: 'Add Answer',
                                                onPressed: () {
                                                  if (controllerList.length <
                                                      5) {
                                                    controllerList.add(
                                                        "answerController");
                                                    controllerList[
                                                            answerItems] =
                                                        TextEditingController();
                                                    answerItems++;
                                                    cubit.addAnswerItem();
                                                  } else {
                                                    showToast(
                                                        message:
                                                            "max answers equal 5");
                                                  }
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
                          cubit.val = -1;
                          answerItems = 0;
                          controllerList.clear();
                          formKey.currentState!.reset();
                          quistionController.clear();
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
                condition: cubit.questions.isNotEmpty,
                builder: (context) =>

                    //     SingleChildScrollView(
                    //       child: Column(
                    //         children: [
                    //           ListView.builder(
                    //             shrinkWrap: true,
                    //   itemBuilder: (context, index) => quistionItem(context, index,cubit.questions[index]),
                    //   itemCount: cubit.questions.length,
                    // ),
                    //         ],
                    //       ),
                    //     ),

                    GridView.count(
                  //   shrinkWrap: true,

                  crossAxisCount: 1,
                  childAspectRatio: 1 / 0.75,
                  children: List.generate(
                    cubit.questions.length,
                    (index) =>
                        quistionItem(context, index, cubit.questions[index]),
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
          }),
    );
  }

  Widget quistionItem(context, index, Question question) {
    return Dismissible(
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
                  child: Container(
                    width: 200,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            question.question,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => answerItem(
                                "${index + 1}",
                                question.options[index],
                                question.answer,
                                index,
                              ),
                              itemCount: question.options.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
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

  Widget answerItem(String ch, String answer,int correctAnswerIndex,int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
             color: correctAnswerIndex==index?primaryColor:null ,

            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                ch,
                style: TextStyle(fontSize: 20,color: correctAnswerIndex==index?Colors.white:null),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                answer,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15,color: correctAnswerIndex==index?Colors.white:null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget answer(
      {required int index,
      required Function onChange,
      required val,
      required controller,
      required label}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: customTextFormFieldWidget(
        type: TextInputType.text,
        prefixIcon: Icons.question_answer_outlined,
        prefix: true,
        label: label,
        controller: controller,
        validate: (value) {
          if (value!.isEmpty) {
            return 'Answer ${index + 1} Must Be Not Empty';
          }
          return null;
        },
      ),
      leading: Radio(
        value: index,
        groupValue: val,
        onChanged: (x) {
          // setState(() {
          //   print(x);
          //   //val=x;
          //
          //   //  val =int.parse(x!);
          // });
          onChange(x);
        },
        activeColor: Colors.green,
      ),
    );
  }
}
