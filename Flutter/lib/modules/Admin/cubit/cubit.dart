import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/author_manger_request.dart';
import 'package:lms/modules/Admin/cubit/states.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);

  AuthorsManagerRequest? authorsManagerRequest;

  Future<void> getAllAuthor() async {
    emit(GetAllAuthorsLoadingState());
    await DioHelper.getData(url: getAllAuthors, token: userToken)
        .then((value) {
      print(value.data);
      authorsManagerRequest = AuthorsManagerRequest.fromJson(value.data);
      emit(GetAllAuthorsSuccessState(authorsManagerRequest!));
    }).catchError((error) {
      emit(GetAllAuthorsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void makeAuthorManagerRole({
    required String? userRequestId,
  }) {
    emit(MakeAuthorManagerLoadingState());
    DioHelper.putData(
      url: makeAuthorManager,
      token: userToken,
      data: {
        'userRequestId': userRequestId,
      },
    ).then((value) {
      print(value.toString());
      getAllAuthor();
      //print(model!.profile!.userName);
      emit(MakeAuthorManagerSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(MakeAuthorManagerErrorState(onError.toString()));
    });
  }
}
