import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';

class AuthorCourseCubit extends Cubit<AuthorCourseStates> {
  AuthorCourseCubit() : super(AuthorCourseInitialState());

  static AuthorCourseCubit get(context) => BlocProvider.of(context);
}
