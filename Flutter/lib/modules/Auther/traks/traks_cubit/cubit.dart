import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../author_courses/author_courses_cubit/status.dart';

class TrackCubit extends Cubit<AuthorCourseStates> {
  TrackCubit() : super(AuthorCourseInitialState());

  static TrackCubit get(context) => BlocProvider.of(context);
}
