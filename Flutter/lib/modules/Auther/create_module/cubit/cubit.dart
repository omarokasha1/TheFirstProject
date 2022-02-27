import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';
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
      //print(content!);
      // value.data['contents'].forEach((element) {
      //
      //   content!.addAll({element.sId!: element.contentTitle!});
      // });

      // cartModel = GetCartModel.fromJson(json.data);
      // cartModel.data.cartItems.forEach((element) {
      //   productCartIds[element.product.id] = element.id;
      //   productsQuantity[element.product.id] = element.quantity;
      // });
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
  }) {
    emit(CreateNewModuleLoadingState());

    DioHelper.postData(
      data: {
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl': content,
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

  void uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    formData = FormData.fromMap({
      "imageUrl": await MultipartFile.fromFile(
        file.path,
      ),
    });
    // FormData formData = new FormData.fromMap({
    //   "name": hospitalNameEng,
    //   "Services": servicejson,
    //   "Image": {
    //     "image": await MultipartFile.fromFile(file.path,
    //         filename: file.path),
    //     "type": "image/png"
    //   },
    // });
  }

  ResponseModel? updateModel;
  String? message;

  void updateNewModule({
    required String moduleId,
    required String moduleName,
    required String description,
    required String duration,
    required content,
    required String moduleType,
  }) {
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

      emit(UpdateModuleSuccssesState(updateModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateModuleErrorState(onError.toString()));
    });
  }

  ResponseModel? deleteModel;

  void deleteModule({required String moduleId}) {
    emit(DeleteModuleLoadingState());
    DioHelper.deleteData(url: "$deleteModule/$moduleId").then((value) {
      deleteModel = ResponseModel.fromJson(value.data);

      emit(DeleteModuleSuccssesState(deleteModel!));
    }).catchError((error) {
      emit(DeleteModuleErrorState(error));
    });
  }
}
