import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/states.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(InitQuizState());

  static QuizCubit get(context) => BlocProvider.of(context);

  bool hasQuistionName = false;

  onCourseNameChanged(String name) {
    hasQuistionName = false;
    if (name.length > 2) {
      hasQuistionName = true;
    }
  }
  bool clickFloat=false;
  void changeCurrentIndex(bool clickFloating)
  {
    clickFloat=clickFloating;

  }


}
