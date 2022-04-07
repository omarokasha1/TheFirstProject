import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/Questions.dart';
import 'package:lms/modules/Auther/quiz/create_quiz/cubit/states.dart';

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

  bool clickFloat = false;

  void changeCurrentIndex(bool clickFloating) {
    clickFloat = clickFloating;
  }

  dynamic val = -1;

  void selectCorrectAnswer(value) {
    val = value;
    emit(SelectCorrectAnswerState());
  }

  void addAnswerItem() {
    emit(AddCorrectAnswerState());
  }
  List<Question> questions = [];
  void addItemInList(Question question)
  {
    questions.add(question);
    emit(AddItemInListState());
  }
  void getItemInList( List<Question> questions)
  {
    questions=questions;
    emit(GetItemInListState());
  }
}
