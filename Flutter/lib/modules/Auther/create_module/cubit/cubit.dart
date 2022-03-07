import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

import '../../../../models/module_model.dart';
import '../../../../models/response_model.dart';
import '../../../../shared/component/constants.dart';
import '../../../../shared/network/end_points.dart';

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

  CreateContent? getModuleModel;
  Map<String, String>? content = {};
  List? list = [];
  List? myActivities = [];

  void changeActivity(value) {
    myActivities = value;
    print(myActivities);
    emit(ChangeActivityState());
  }

  void getModulesData() {
    print(userToken);
    emit(GetNewModuleLoadingState());

    DioHelper.getData(url: getModule, token: userToken).then((value) {
      //print(value.data);
      list = [];
      getModuleModel = CreateContent.fromJson(value.data);

      getModuleModel!.contents!.forEach((element) {
        list!.add({'display': element.contentTitle, 'value': element.sId});
      });
      print(
          "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${list.toString()}");
      emit(GetNewModuleSuccssesState(getModuleModel!));
    }).catchError((error) {
      emit(GetNewModuleErrorState(error.toString()));
      print(error.toString());
    });
  }

  // Future<void> getAllModules() async {
  //   emit(AllModulesLoadingState());
  //   await DioHelper.getData(url: getAuthorTrack, token: userToken).then((value) {
  //     //trackModel!.tracks = [];
  //     trackModel = TrackModel.fromJson(value.data);
  //     emit(AllTrackSuccessState(trackModel));
  //   }).catchError((error) {
  //     emit(AllTrackErrorState(error.toString()));
  //     print(error.toString());
  //   });
  // }
  CreateContent? createContentModel;

  Future<void> createNewModule({
    required String moduleName,
    required String description,
    required String duration,
    required content,
  })async  {
    emit(CreateNewModuleLoadingState());

    DioHelper.postData(
      files: true,
      data: {
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl':await fileUpload(content),
      },
      url: module,
      token: userToken,
    ).then((value) {
      createContentModel = CreateContent.fromJson(value.data);
      getModulesData();
      emit(CreateNewModuleSuccssesState(createContentModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateNewModuleErrorState(onError.toString()));
    });
  }

  Response? response;
  FormData? formData;

  // void uploadFile(File file) async {
  //   String fileName = file.path.split('/').last;
  //   formData = FormData.fromMap({
  //     "imageUrl": await MultipartFile.fromFile(
  //       file.path,
  //     ),
  //   });
  //   // FormData formData = new FormData.fromMap({
  //   //   "name": hospitalNameEng,
  //   //   "Services": servicejson,
  //   //   "Image": {
  //   //     "image": await MultipartFile.fromFile(file.path,
  //   //         filename: file.path),
  //   //     "type": "image/png"
  //   //   },
  //   // });
  // }

  ResponseModel? updateModel;
  String? message;

  Future <void> updateNewModule({
    required moduleId,
    required String moduleName,
    required String description,
    required String duration,
    required content,
    required String moduleType,
  }) async {
    emit(UpdateModuleLoadingState());

    DioHelper.putData(
      data: {
        "id": moduleId,
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl': content,
        'contentType': moduleType,
      },
      url: updateModule,
      token: userToken,
    ).then((value) {
      updateModel = ResponseModel.fromJson(value.data);
      showToast(message: '${updateModel!.message}',color: Colors.green);
      emit(UpdateModuleSuccssesState(updateModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateModuleErrorState(onError.toString()));
    });
  }

  ResponseModel? deleteModel;

  void deleteModule({required String moduleId}) {
    emit(DeleteModuleLoadingState());
    DioHelper.deleteData(url: "$deleteOneModule/$moduleId").then((value) {
      deleteModel = ResponseModel.fromJson(value.data);
      getModulesData();
      emit(DeleteModuleSuccssesState(deleteModel!));
    }).catchError((error) {
      emit(DeleteModuleErrorState(error));
    });
  }
  void selectImage()
  {
    emit(SelectImageState());
  }
}
