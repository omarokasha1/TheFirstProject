import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/tracks_details/bloc/states.dart';

class TracksDetailsCubit extends Cubit<TracksDetailsStates> {
  TracksDetailsCubit() : super(InitTracksDetailsState());

  static TracksDetailsCubit get(context) => BlocProvider.of(context);

  bool hasModuleName = false;

  onReadMoreChanged(String name) {
    hasModuleName = false;
    if (name.length > 2) {
      hasModuleName = true;
    }
  }
}
