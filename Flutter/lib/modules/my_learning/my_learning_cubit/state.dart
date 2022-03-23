import 'package:lms/models/course_model.dart';
import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

import 'package:lms/modules/my_learning/mylearning.dart';

abstract class MyLearningStates {}

class MyLearningInitialState extends MyLearningStates {}

class MyLearningLoadingState extends MyLearningStates {}

class MyLearningSuccessState extends MyLearningStates {
  final List<CourseModel?> courseModel;

  MyLearningSuccessState(this.courseModel);
}

class MyLearningErrorState extends MyLearningStates {
  final String error;

  MyLearningErrorState(this.error);
}

class GetWishlistCoursesLoadingState extends MyLearningStates{}
class GetWishlistCoursesSuccessState extends MyLearningStates{}
class GetWishlistCoursesErrorState extends MyLearningStates{
  final String error;
  GetWishlistCoursesErrorState(this.error);
}

class GetEnrolledCoursesLoadingState extends MyLearningStates{}
class GetEnrolledCoursesSuccessState extends MyLearningStates{}
class GetEnrolledCoursesErrorState extends MyLearningStates{
  final String error;
  GetEnrolledCoursesErrorState(this.error);
}
