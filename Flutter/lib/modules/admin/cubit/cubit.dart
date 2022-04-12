import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/author_manger_request.dart';
import 'package:lms/modules/admin/cubit/states.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

import '../../../models/new/courses_model.dart';
import '../../../models/track_model.dart';
import '../../../models/user.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(ManagerInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  AuthorsManagerRequest? authorsManagerRequest;

  Future<void> getAllAuthor() async {
    emit(GetAllAuthorsLoadingState());
    await DioHelper.getData(url: getAllAuthors, token: userToken)
        .then((value) {
      authorsManagerRequest = AuthorsManagerRequest.fromJson(value.data);
      search = authorsManagerRequest!.users!;
      emit(GetAllAuthorsSuccessState(authorsManagerRequest!));
    }).catchError((error) {
      emit(GetAllAuthorsErrorState(error.toString()));
      print(error.toString());
    });
  }

  AuthorsManagerRequest? allUsersModel;
  List<Users> author =[];
  List<Users> manager =[];
  List<Users> user =[];
  void getUserData() {
    emit(GetAllUsersLoadingState());
    DioHelper.getData(
        url: allUsers,
      ).then((value)
      {
        allUsersModel = AuthorsManagerRequest.fromJson(value.data);
        author =allUsersModel!.users!;
        manager =allUsersModel!.users!;
        user =allUsersModel!.users!;
        emit(GetAllUsersSuccessState());
        author=allUsersModel!.users!.where((element){
          return element.isAuthor == true && element.isAdmin ==false && element.isManager == false;
        }).toList();
        manager=allUsersModel!.users!.where((element){
          return element.isManager == true && element.isAdmin ==false;
        }).toList();
        user=allUsersModel!.users!.where((element){
          return element.isAdmin ==false;
        }).toList();
        emit(GetAllUsersSuccessState());
        print("Number of author >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${author.length}");
        print("Number of manager >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${manager[0].userName}");
        print("Number of manager >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${user.length}");
        print("Number of user >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${allUsersModel!.users!.length}");
      }).catchError((error){
      emit(GetAllUsersErrorState(error.toString()));
      print(error.toString());
      });


  }

  CoursesModel?  numberOfCourses ;
  Future<void> getNumberOfCourses() async {
    emit(GetAllNumberCoursesLoadingState());
    await DioHelper.getData(url: getAuthorCoursesPublished, token: userToken).then((value) {
      numberOfCourses = CoursesModel.fromJson(value.data);
      emit(GetAllNumberCoursesSuccessState(numberOfCourses!));
    }).catchError((error) {
      emit(GetAllNumberCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

  TrackModel? trackNumber;
  Future<void> getNumberOfTracks() async {
    emit(GetAllNumberTracksLoadingState());
    await DioHelper.getData(url: getAuthorTrackPublished, token: userToken).then((value) {
      trackNumber = TrackModel.fromJson(value.data);
      emit(GetAllNumberTracksSuccessState(trackNumber!));
    }).catchError((error) {
      emit(GetAllNumberTracksErrorState(error.toString()));
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
        final emailLower = element.email!.toLowerCase();
        final phoneLower = element.phone!.toLowerCase();
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
      //print(model!.profile!.userName);
      emit(MakeAuthorManagerSuccessState());
      getAllAuthor();
    }).catchError((onError) {
      print(onError.toString());
      emit(MakeAuthorManagerErrorState(onError.toString()));
    });
  }
}