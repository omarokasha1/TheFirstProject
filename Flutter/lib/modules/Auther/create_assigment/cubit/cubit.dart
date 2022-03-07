import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/states.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';
import '../../../../models/module_model.dart';
import '../../../../models/response_model.dart';
import '../../../../shared/component/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio-helper.dart';

class CreateAssignmentCubit extends Cubit<CreateAssignmentStates> {
  CreateAssignmentCubit() : super(InitCreateAssignmentState());

  static CreateAssignmentCubit get(context) => BlocProvider.of(context);

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
    emit(ChangeAActivityState());
  }

  void getModulesData() {
    print(userToken);
    emit(GetNewAssignmentLoadingState());

    DioHelper.getData(url: getAssignment, token: userToken).then((value) {
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
      emit(GetNewAssignmentSuccssesState(getModuleModel!));
    }).catchError((error) {
      emit(GetNewAssignmentErrorState(error.toString()));
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
    emit(CreateNewAssignmentLoadingState());

    DioHelper.postData(
      data: {
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl': content,
      },
      url: newAssignment,
      token: userToken,
    ).then((value) {
      createContentModel = CreateContent.fromJson(value.data);
      emit(CreateNewAssignmentSuccssesState(createContentModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateNewAssignmentErrorState(onError.toString()));
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
  }) {
    emit(UpdateAssignmentLoadingState());

    DioHelper.putData(
      data: {
        "id": moduleId,
        'contentTitle': moduleName,
        'description': description,
        'contentDuration': duration,
        'imageUrl': content,
      },
      url: updateAssignment,
      token: userToken,
    ).then((value) {
      updateModel = ResponseModel.fromJson(value.data);

      emit(UpdateAssignmentSuccssesState(updateModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateAssignmentErrorState(onError.toString()));
    });
  }

  ResponseModel? deleteModel;

  void deleteAssignment({required String moduleId}) {
    emit(DeleteAssignmentLoadingState());
    DioHelper.deleteData(url: "$deleteDataAssignment/$moduleId").then((value) {
      deleteModel = ResponseModel.fromJson(value.data);
      emit(DeleteAssignmentSuccssesState(deleteModel!));
    }).catchError((error) {
      emit(DeleteAssignmentErrorState(error));
    });
  }
}
