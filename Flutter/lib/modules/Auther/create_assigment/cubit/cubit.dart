import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/states.dart';

import '../../../../models/module_model.dart';
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

  List<String> items = ['Content', 'Assignment'];
  String selectedItem = "Content";

  void changeItem(String value) {
    selectedItem = value;
    emit(ChangeItemStateAssignment());
  }

  CreateContent? getModuleModel;
  Map<String, String>? content = {};
  List? list = [];
  List? myActivities = [];

  void changeActivity(value) {
    myActivities = value;
    print(myActivities);
    emit(ChangeActivityStateAssignment());
  }

  void getModulesData() {
    print(userToken);
    emit(GetNewAssignmentLoadingState());

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
    required String moduleType,
  }) {
    emit(CreateNewAssignmentLoadingState());

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
  }



}
