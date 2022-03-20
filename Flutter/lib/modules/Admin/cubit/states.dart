import 'package:lms/models/author_manger_request.dart';

abstract class ManagerStates {}

class ManagerInitialState extends ManagerStates {}

class GetAllAuthorsLoadingState extends ManagerStates{}
class GetAllAuthorsSuccessState extends ManagerStates{
  final AuthorsManagerRequest authorsManagerRequest;
  GetAllAuthorsSuccessState(this.authorsManagerRequest);
}
class GetAllAuthorsErrorState extends ManagerStates{
  final String error;
  GetAllAuthorsErrorState(this.error);
}

class MakeAuthorManagerLoadingState extends ManagerStates{}
class MakeAuthorManagerSuccessState extends ManagerStates{}
class MakeAuthorManagerErrorState extends ManagerStates{
  final String error;
  MakeAuthorManagerErrorState(this.error);
}
