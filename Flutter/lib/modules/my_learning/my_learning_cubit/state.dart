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
