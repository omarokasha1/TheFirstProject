import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import 'package:lms/modules/quiz/screens/welcome/welcome_screen.dart';

import '../../../../shared/component/component.dart';
import '../../../../shared/component/constants.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<QuizCubit,QuizStates>(
      listener: (context,state){},
      builder:(context,state) {

        var cubit =QuizCubit.get(context);
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [

              Column(
                children: [
                  Spacer(),
                  Text(
                    "Your Score is ",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: secondaryColor),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "${cubit.numOfCorrectAns }/${cubit.questions.length }",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: secondaryColor),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: defaultButton(onPressed: (){
                      cubit.clearDate();
                      navigatorAndRemove(context, WelcomeScreen());
                    },text: "Go Welcome"),
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
