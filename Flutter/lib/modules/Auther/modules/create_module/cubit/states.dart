

import 'package:lms/models/module_model.dart';
import 'package:lms/models/new/contents_model.dart';
import 'package:lms/models/response_model.dart';

import '../../../../../models/assignment_model.dart';

abstract class CreateModuleStates {}

class InitCreateModuleState extends CreateModuleStates {}

class ChangeItemState extends CreateModuleStates {}

class CreateNewModuleLoadingState extends CreateModuleStates {}

class CreateNewModuleSuccssesState extends CreateModuleStates {

  final CreateContent createContentModel;
  CreateNewModuleSuccssesState(this.createContentModel);
}

class CreateNewModuleErrorState extends CreateModuleStates {
  final String error;
  CreateNewModuleErrorState(this.error);
}
class GetContentsLoadingState extends CreateModuleStates {}

class GetContentsSuccssesState extends CreateModuleStates {

  final ContentsModel createContentModel;
  GetContentsSuccssesState(this.createContentModel);
}

class GetContentsErrorState extends CreateModuleStates {
  final String error;
  GetContentsErrorState(this.error);
}
class ChangeContentActivityState extends CreateModuleStates {}
class ChangeAssignmentActivityState extends CreateModuleStates {}
class ChangeQuizActivityState extends CreateModuleStates {}

class UpdateModuleLoadingState extends CreateModuleStates {}

class UpdateModuleSuccssesState extends CreateModuleStates {

  final ResponseModel  responseModel;
  UpdateModuleSuccssesState(this.responseModel);
}

class UpdateModuleErrorState extends CreateModuleStates {
  final String error;
  UpdateModuleErrorState(this.error);
}
class DeleteModuleLoadingState extends CreateModuleStates {}

class DeleteModuleSuccssesState extends CreateModuleStates {

  final ResponseModel responseModel;
  DeleteModuleSuccssesState(this.responseModel);
}

class DeleteModuleErrorState extends CreateModuleStates {
  final String error;
  DeleteModuleErrorState(this.error);
}

class GetAssignmentsLoadingState extends CreateModuleStates {}

class GetAssignmentsSuccssesState extends CreateModuleStates {

  final AssignmentsModel assignmentsModel;
  GetAssignmentsSuccssesState(this.assignmentsModel);
}

class GetAssignmentsErrorState extends CreateModuleStates {
  final String error;
  GetAssignmentsErrorState(this.error);
}


class SelectImageState extends CreateModuleStates {}