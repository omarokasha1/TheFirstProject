import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/Auther/create_quiz/cubit/states.dart';
import 'package:lms/shared/network/end_points.dart';
import '../../../../models/Questions.dart';
import '../../../../models/new/question_model.dart';
import '../../../../models/new/quiz_model.dart';
import '../../../../shared/component/constants.dart';
import '../../../../shared/network/remote/dio-helper.dart';

class QuizsCubit extends Cubit<QuizStates> {
  QuizsCubit() : super(InitQuizState());

  static QuizsCubit get(context) => BlocProvider.of(context);
  QuestionModel? questionModel ;



List<bool>checked =[];
  List<String> contentId =[];
  void changeCheckBox(bool value,index) {

    checked[index]= value;
    emit(CheckBoxState());
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



  Future<void> createNewQuiz({
    required String quizName,
    required List<String> questions,
    // List<String>? courses,

  }) async {
    emit(CreateQuizLoadingState());
    DioHelper.postData(
      files: false,
      data: {
        'quizName': quizName,
        'questions': questions,
       // 'courses' : courses ?? [""],

      },
      url: createAuthorQuizzes,
      token: userToken,
    ).then((value) async {
      debugPrint('Hereeeeeee : ${value.data}');
      emit(CreateQuizSuccessState());
      getAuthorQuizes();
   //   getAuthorCoursesData();
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(CreateQuizErrorState(onError.toString()));
    });
  }

  QuizModel? quizModel ;

  Future<void> getAuthorQuizes() async {
    emit(GetAuthorQuizLoadingState());

    await DioHelper.getData(url: getAuthorQuizzes,
      token: userToken,
    ).then((value) {
      //debugPrint(value.data);
      //authorQuizsTestModel!.courses=[];
      quizModel = QuizModel.fromJson(value.data);
      //questions.addAll(iterable);
      print(quizModel!.quizes![0].quizName);
      emit(GetAuthorQuizSuccessState(quizModel!));
    }).catchError((error) {
      emit(GetAuthorQuizErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  Future<void> deleteQuiz({required String id,}) async {
    emit(DeleteAuthorQuizLoadingState());

    await DioHelper.deleteData(url:'$deleteAuthorQuizzes/$id',
    ).then((value) {
      //debugPrint(value.data);
      //authorQuizsTestModel!.courses=[];
      //   questionModel = QuizModel.fromJson(value.data);
      //questions.addAll(iterable);
      print(value.data);
      getAuthorQuizes();
      emit(DeleteAuthorQuizSuccessState(quizModel!));
    }).catchError((error) {
      emit(DeleteAuthorQuizErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }



  Future<void> createNewQuestion({
    required String questionTitle,
    required int answerIndex,
    required List<String> options,

  }) async {
    emit(CreateQuestionLoadingState());
    DioHelper.postData(
      files: false,
      data: {
        'questionTitle': questionTitle,
        'answerIndex': answerIndex,
        'options' : options,

      },
      url: createAuthorQuestions,
      token: userToken,
    ).then((value) async {
      debugPrint('Hereeeeeee : ${value.data}');
     // getAuthorQuestion();
      emit(CreateQuestionSuccessState());
      //   getAuthorCoursesData();
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(CreateQuestionErrorState(onError.toString()));
    });
  }


  Future<void> getAuthorQuestion() async {
    emit(GetAuthorQuestionLoadingState());

    await DioHelper.getData(url: getAuthorQuestions,
      token: userToken,
    ).then((value) {
      //debugPrint(value.data);
      //authorQuestionsTestModel!.courses=[];
      questionModel = QuestionModel.fromJson(value.data);
      //questions.addAll(iterable);
      print(questionModel!.questions![0].questionTitle);
      emit(GetAuthorQuestionSuccessState(questionModel!));
    }).catchError((error) {
      emit(GetAuthorQuestionErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  Future<void> deleteQuestion({required String id,}) async {
    emit(DeleteAuthorQuestionLoadingState());

    await DioHelper.deleteData(url:'$deleteAuthorQuestions/$id',

    ).then((value) {
      //debugPrint(value.data);
      //authorQuestionsTestModel!.courses=[];
   //   questionModel = QuestionModel.fromJson(value.data);
      //questions.addAll(iterable);
      print(value.data);
      getAuthorQuestion();
      emit(DeleteAuthorQuestionSuccessState(questionModel!));
    }).catchError((error) {
      emit(DeleteAuthorQuestionErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
}
