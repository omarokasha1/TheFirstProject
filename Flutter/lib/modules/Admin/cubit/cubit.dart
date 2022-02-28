
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Admin/cubit/states.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);
  bool flag= true;
void changeButton(){
   flag =! flag;
   emit(ChangeButtonState());
}}
