import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/assignment_model.dart';
import 'package:lms/models/response_model.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class AssignmentCubit extends Cubit<CreateAssignmentStates> {
  AssignmentCubit() : super(InitCreateAssignmentState());

  static AssignmentCubit get(context) => BlocProvider.of(context);

  bool hasModuleName = false;

  onModuleNameChanged(String name) {
    hasModuleName = false;
    if (name.length > 2) {
      hasModuleName = true;
    }
  }

  void selectImage() {
    emit(SelectImageState());
  }

  AssignmentsModel? assignments;
  List? assignmentList = [];
  List? myActivities = [];

  void changeActivity(value) {
    myActivities = value;
    print(myActivities);
    emit(ChangeAActivityState());
  }

  Future<void> getAssignmentData() async {
    print(userToken);
    emit(GetAssignmentsLoadingState());

    await DioHelper.getData(url: getAssignment, token: userToken).then((value) {
      //print(value.data);
      assignmentList = [];
      assignments = AssignmentsModel.fromJson(value.data);
      assignments!.assignments!.forEach((element) {
        assignmentList!
            .add({'display': element.assignmentTitle, 'value': element.sId});
      });
      emit(GetAssignmentsSuccssesState(assignments!));
    }).catchError((error) {
      emit(GetAssignmentsErrorState(error.toString()));
      print(error.toString());
    });
  }

  AssignmentsModel? createAssignmentsModel;

  Future<void> createAssignment({
    required String moduleName,
    required String description,
    required String duration,
    required content,
  }) async {
    emit(CreateNewAssignmentLoadingState());

    DioHelper.postData(
      files: true,
      data: {
        'assignmentTitle': moduleName,
        'description': description,
        'assignmentDuration': duration,
        'fileUrl': await fileUpload(content),
      },
      url: newAssignment,
      token: userToken,
    ).then((value) async {
      print("value======>$value.data");

      createAssignmentsModel = AssignmentsModel.fromJson(value.data);
      await getAssignmentData();
      print("value======>$value.data");

      emit(CreateNewAssignmentSuccssesState(createAssignmentsModel!));
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

  Future<void> updateAssignmentData({
    required String moduleId,
    required String moduleName,
    required String description,
    required String duration,
    required file,
    //   content,
  }) async {
    emit(UpdateAssignmentLoadingState());

    DioHelper.putData(
      data: {
        "sId": moduleId,
        'assignmentTitle': moduleName,
        'description': description,
        'assignmentDuration': duration,
        'fileUrl':  await fileUpload(file),
      },
      files: true,
      url: updateAssignment,
      token: userToken,
    ).then((value) async {
      updateModel = ResponseModel.fromJson(value.data);
      print(value.data);
      print(updateModel!.message);
      showToast(message: "${updateModel!.message}");
      await getAssignmentData();
      print("value======>${updateModel}");
      emit(UpdateAssignmentSuccssesState(updateModel!));
    }).catchError((onError) {
      print("onError======>${onError}");

      print(onError.toString());
      emit(UpdateAssignmentErrorState(onError.toString()));
    });
  }

  ResponseModel? deleteModel;

  void deleteAssignment({required String moduleId}) {
    emit(DeleteAssignmentLoadingState());
    DioHelper.deleteData(url: "$deleteDataAssignment/$moduleId").then((value) async {
      deleteModel = ResponseModel.fromJson(value.data);
      await getAssignmentData();
      showToast(message: "${deleteModel!.message}");
      emit(DeleteAssignmentSuccssesState(deleteModel!));
    }).catchError((error) {
      emit(DeleteAssignmentErrorState(error));
    });
  }
}
