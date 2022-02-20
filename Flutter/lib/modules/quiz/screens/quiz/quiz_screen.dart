import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/modules/quiz/cubit/states.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = QuizCubit.get(context);
          return const  Scaffold(
            extendBodyBehindAppBar: true,

            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Body(),
            ),
          );
        });
  }
}
