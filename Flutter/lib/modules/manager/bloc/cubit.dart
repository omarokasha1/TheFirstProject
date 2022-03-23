import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/author_request.dart';
import 'package:lms/modules/manager/bloc/states.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerRequestAuthorInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);

  AuthorRequests? authorRequests;

  Future<void> getAuthorRequests() async {
    emit(GetAllAuthorRequestsLoadingState());
    await DioHelper.getData(url: getAuthorRequest, token: userToken)
        .then((value) {
      print(value.data);
      authorRequests = AuthorRequests.fromJson(value.data);
      emit(GetAllAuthorRequestsSuccessState(authorRequests!));
    }).catchError((error) {
      emit(GetAllAuthorRequestsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserProfile({
    required String? userRequestId,
  }) {
    emit(UpdateUserRoleLoadingState());
    DioHelper.putData(
      url: updateUserRoleAuthor,
      token: userToken,
      data: {
        'userRequestId': userRequestId,
      },
    ).then((value) {
      print(value.toString());
      getAuthorRequests();
      //print(model!.profile!.userName);
      emit(UpdateUserRoleSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateUserRoleErrorState(onError.toString()));
    });
  }

  void deleteAuthorRequest({required String userRequestId}) {
    emit(DeleteAuthorRequestLoadingState());
    DioHelper.deleteData(url: deleteUserRequest, data: {
      "userRequestId": userRequestId,
    }).then((value) {
      print(value.data);
      getAuthorRequests();
      emit(DeleteAuthorRequestSuccessState());
    }).catchError((error) {
      emit(DeleteAuthorRequestErrorState(error));
    });
  }
}