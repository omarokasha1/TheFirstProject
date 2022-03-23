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
      search = authorsManagerRequest!.users!;
      emit(GetAllAuthorsSuccessState(authorsManagerRequest!));
    }).catchError((error) {
      emit(GetAllAuthorsErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<Users?> search = [];
  void searchManager (String word){
    search = authorsManagerRequest!.users!;
    emit(SearchManagerLoadingState());
    if(word.isEmpty){
      search = authorsManagerRequest!.users!;
    }else{
      search = authorsManagerRequest!.users!.where((element) {
        final usernameLower = element.userName!.toLowerCase();
        final emailLower =
        element.email!.toLowerCase();
        final phoneLower =
        element.phone!.toLowerCase();
        final searchLower = word.toLowerCase();

        return usernameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phoneLower.contains(searchLower);
      }).toList();
    }
    emit(SearchManagerSuccessState());
    //return search;
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
