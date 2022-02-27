import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import '../../../../../models/Questions.dart';
import '../../../../../shared/component/constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: secondaryColor,width: 1)

      ),
      child: BlocConsumer<QuizCubit, QuizStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = QuizCubit.get(context);
            cubit.context = context;
            return SingleChildScrollView(
              child: Column(

                children: [
                  Text(
                    question.question,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: kBlackColor),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  ...List.generate(
                    question.options.length,
                    (index) => Option(
                      index: index,
                      text: question.options[index],
                      press: () {
                        cubit.context = context;
                        cubit.checkAns(question, index);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
