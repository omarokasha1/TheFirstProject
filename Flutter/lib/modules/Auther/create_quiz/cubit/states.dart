

import '../../../../models/new/question_model.dart';
import '../../../../models/new/quiz_model.dart';

abstract class QuizStates {}

class InitQuizState extends QuizStates {}

class SelectCorrectAnswerState extends QuizStates {}
class CheckBoxState extends QuizStates {}
class AddCorrectAnswerState extends QuizStates {}
class AddItemInListState extends QuizStates {}
class GetItemInListState extends QuizStates {}


class CreateQuizLoadingState extends QuizStates {}
class CreateQuizSuccessState extends QuizStates {}
class CreateQuizErrorState extends QuizStates {
  final String error;

  CreateQuizErrorState(this.error);
}


class GetAuthorQuizLoadingState extends QuizStates {}
class GetAuthorQuizSuccessState extends QuizStates {
  final QuizModel quizModel;

  GetAuthorQuizSuccessState(this.quizModel);
}
class GetAuthorQuizErrorState extends QuizStates {
  final String error;

  GetAuthorQuizErrorState(this.error);
}

class DeleteAuthorQuizLoadingState extends QuizStates {}
class DeleteAuthorQuizSuccessState extends QuizStates {
  final QuizModel quizModel;

  DeleteAuthorQuizSuccessState(this.quizModel);
}
class DeleteAuthorQuizErrorState extends QuizStates {
  final String error;

  DeleteAuthorQuizErrorState(this.error);
}


// ______________________________Question____________________________
class CreateQuestionLoadingState extends QuizStates {}
class CreateQuestionSuccessState extends QuizStates {}
class CreateQuestionErrorState extends QuizStates {
  final String error;

  CreateQuestionErrorState(this.error);
}

class GetAuthorQuestionLoadingState extends QuizStates {}
class GetAuthorQuestionSuccessState extends QuizStates {
  final QuestionModel questionModel;

  GetAuthorQuestionSuccessState(this.questionModel);
}
class GetAuthorQuestionErrorState extends QuizStates {
  final String error;

  GetAuthorQuestionErrorState(this.error);
}

class DeleteAuthorQuestionLoadingState extends QuizStates {}
class DeleteAuthorQuestionSuccessState extends QuizStates {
  final QuestionModel questionModel;

  DeleteAuthorQuestionSuccessState(this.questionModel);
}
class DeleteAuthorQuestionErrorState extends QuizStates {
  final String error;

  DeleteAuthorQuestionErrorState(this.error);
}