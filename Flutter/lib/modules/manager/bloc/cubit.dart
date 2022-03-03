import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/manager/bloc/states.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerRequestAuthorInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);
}