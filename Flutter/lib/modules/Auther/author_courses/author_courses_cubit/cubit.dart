import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class AuthorCoursesCubit extends Cubit<AuthorCoursesStates> {
  AuthorCoursesCubit() : super(AuthorCourseInitialState());

  static AuthorCoursesCubit get(context) => BlocProvider.of(context);
}
