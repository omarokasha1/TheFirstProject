import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/traks/traks_cubit/status.dart';

import '../../author_courses/author_courses_cubit/status.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());

  static TrackCubit get(context) => BlocProvider.of(context);

}
