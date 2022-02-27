
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import '../../../../../shared/component/constants.dart';
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: BlocConsumer<QuizCubit, QuizStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = QuizCubit.get(context);

            return Builder(
              //   init: QuestionController(),
              builder: (context) {
                return Stack(
                  children: [
                    // LayoutBuilder(
                    //
                    //   builder: (context, constraints) => Container(
                    //     // from 0 to 1 it takes 60s
                    //     width: constraints.maxWidth * animation.value,
                    //     decoration: BoxDecoration(
                    //       gradient: newVv,
                    //       borderRadius: BorderRadius.circular(50),
                    //     ),
                    //   ),
                    // ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${cubit.seconds} sec",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            const Icon(Icons.lock_clock),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
