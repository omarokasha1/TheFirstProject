import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import '../../../../shared/component/component.dart';
import '../../../../shared/component/constants.dart';
import '../quiz/quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit,QuizStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit =QuizCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [

              SafeArea(
                child: Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          //  const    Spacer(),
                            Text(
                              "Let's Play Quiz,",
                              style: Theme.of(context).textTheme.headline4?.copyWith(
                                   fontWeight: FontWeight.bold),
                            ),
                            const  Text("If You Ready Click Lets Start"),

                            const  SizedBox(height: 70,),
                            InkWell(
                              onTap: () {
                                navigatorAndRemove(context, QuizScreen());

                                    cubit.startTimer();



                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                                  decoration:const  BoxDecoration(
                                    gradient: newVv,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: Text(
                                    "Lets Start Quiz",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                         //   const    Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
