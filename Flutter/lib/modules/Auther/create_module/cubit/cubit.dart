import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';

import '../../../../models/module_model.dart';
import '../../../../shared/component/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio-helper.dart';

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

  List<String> items = ['Content', 'Assignment'];
  String selectedItem = "Content";

  void changeItem(String value) {
    selectedItem = value;
    emit(ChangeItemState());
  }

  CreateContent? createContentModel;

  void createNewModule({
    required String moduleName,
    required String description,
    required String duration,
   // required File content,
    required String moduleType,
  }) {
    emit(CreateNewModuleLoadingState());
    DioHelper.postData(
      data: {
        'contentTitle':moduleName,
        'description':description,
        'contentDuration':duration,
       // '':content,
        'contentType':moduleType,
      },
      url: module,
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMDBmZjc3MzA0OWY3ZDUyYzM3NWRhMCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTY0NDY3NDEyOX0.Yf9fhh-y_HDFtmUw4EeCKhr11Xw0bGPvM2q6ehpZyQQ",
    ).then((value) {
      createContentModel = CreateContent.fromJson(value.data);
      emit(CreateNewModuleSuccssesState(createContentModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateNewModuleErrorState(onError.toString()));
    });
  }
}
