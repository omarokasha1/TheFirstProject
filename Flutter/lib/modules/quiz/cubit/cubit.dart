import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/states.dart';
import '../../../models/Questions.dart';
import '../../../shared/component/component.dart';
import '../screens/score/score_screen.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(InitQuizState());

  static QuizCubit get(context) => BlocProvider.of(context);

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  int? _correctAns = 0;

  int get correctAns => _correctAns!;

  int? _selectedAns;

  int get selectedAns => _selectedAns!;

  int _questionNumber = 1;

  int get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => _numOfCorrectAns;

  void clearDate()
  {
    _numOfCorrectAns = 0;
     _questionNumber = 1;
     _isAnswered = false;
  }
  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    emit(CheckAnsState());
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  var context;

  dynamic nextQuestion() {
    seconds = maxSecond;
    emit(NextQues());
    if (_questionNumber != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      timer!.cancel();
      navigatorAndRemove(context, ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber = index + 1;
  }

  static const maxSecond = 60;
  int seconds = maxSecond;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds == -1) {
        nextQuestion();
      }

      emit(StateX());
    });
  }
}
