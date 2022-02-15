import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/shared/cubit%20For%20Internet/states.dart';

class InternetCubit extends Cubit<InternetStates> {
  InternetCubit() : super(InternetStatesInitialState());

  static InternetCubit get(context) => BlocProvider.of(context);

  void checkInternetConnection() {
    emit(CheckInternetConnectionState());
  }
}
