import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/quiz/quiz_cubit/status.dart';


class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(QuizInitialState());

  static QuizCubit get(context) => BlocProvider.of(context);
}
