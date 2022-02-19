import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/modules_library/modules_library_cubit/status.dart';


class ModulesLibraryCubit extends Cubit<ModulesLibraryStates> {
  ModulesLibraryCubit() : super(ModulesLibraryInitialState());

  static ModulesLibraryCubit get(context) => BlocProvider.of(context);
}
