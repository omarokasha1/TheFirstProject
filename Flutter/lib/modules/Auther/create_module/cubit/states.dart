

import 'package:lms/models/module_model.dart';
import 'package:lms/models/response_model.dart';

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
class GetNewModuleLoadingState extends CreateModuleStates {}

class GetNewModuleSuccssesState extends CreateModuleStates {

  final CreateContent createContentModel;
  GetNewModuleSuccssesState(this.createContentModel);
}

class GetNewModuleErrorState extends CreateModuleStates {
  final String error;
  GetNewModuleErrorState(this.error);
}
class ChangeActivityState extends CreateModuleStates {}

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