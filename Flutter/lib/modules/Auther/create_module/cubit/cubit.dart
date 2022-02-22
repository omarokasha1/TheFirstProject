import 'dart:io';

import 'package:dio/dio.dart';
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

  CreateContent? getModuleModel;

  void getModulesData() {
    emit(GetNewModuleLoadingState());
    DioHelper.getData(url: getModule, token: userToken).then((value) {
      getModuleModel = CreateContent.fromJson(value.data);
      print(getModuleModel!.status);
      emit(GetNewModuleSuccssesState(getModuleModel!));
    }).catchError((error) {
      emit(GetNewModuleErrorState(error.toString()));
      print(error.toString());
    });
  }

  CreateContent? createContentModel;

  void createNewModule({
    required String moduleName,
    required String description,
    required String duration,
    required content,
    required String moduleType,
  }) {
    emit(CreateNewModuleLoadingState());

    DioHelper.postData(
      data: {
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl': content,
        'contentType': moduleType,
      },
      url: module,
      token: userToken,
    ).then((value) {
      createContentModel = CreateContent.fromJson(value.data);
      emit(CreateNewModuleSuccssesState(createContentModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateNewModuleErrorState(onError.toString()));
    });
  }

  Response? response;
  FormData? formData;
  void  uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    formData= FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });


  }
}
