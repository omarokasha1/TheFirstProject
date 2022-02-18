import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';

class CreateModuleCubit extends Cubit<CreateModuleStates> {
  CreateModuleCubit() : super(InitCreateModuleState());

  static CreateModuleCubit get(context) => BlocProvider.of(context);

  bool hasModuleName = false;

  onModuleNameChanged(String name) {
    hasModuleName = false;
    if (name.length > 2) {
      hasModuleName = true;
    }
  }
}
