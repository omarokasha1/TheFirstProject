import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/traks/traks_cubit/status.dart';

import '../../author_courses/author_courses_cubit/status.dart';

class AuthorTrackCubit extends Cubit<AuthorTrackStates> {
  AuthorTrackCubit() : super(AuthorTrackInitialState());

  static AuthorTrackCubit get(context) => BlocProvider.of(context);
}
