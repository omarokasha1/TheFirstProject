import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<QuizCubit,QuizStates>(listener: (context,state){},builder: (context,state){
      var cubit=QuizCubit.get(context);

      return Stack(
        fit: StackFit.expand,
        children: [
         // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(
                  padding:
                   EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ProgressBar(),
                  //child: Container(),
                ),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child:  Text.rich(
                      TextSpan(
                        text:
                        "Question ${cubit.questionNumber}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: secondaryColor),
                        children: [
                          TextSpan(
                            text: "/${cubit.questions.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: secondaryColor),
                          ),
                        ],

                    ),
                  ),
                ),
                Divider(thickness: 1.5),
                SizedBox(height: kDefaultPadding),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    // Block swipe to next qn
                    physics: NeverScrollableScrollPhysics(),
                    controller: cubit.pageController,
                    onPageChanged: cubit.updateTheQnNum,
                    itemCount: cubit.questions.length,
                    itemBuilder: (context, index) => QuestionCard(
                        question: cubit.questions[index]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: defaultButton(onPressed: (){
                    cubit.nextQuestion();
                  },text: "SKip Question ${cubit.questionNumber}"),
                ),

              ],
            ),
          )
        ],
      );
    },);
  }
}
