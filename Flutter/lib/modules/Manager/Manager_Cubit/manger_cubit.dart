import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Manager/Manager_Cubit/manager_states.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerRequestAuthorInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);
}