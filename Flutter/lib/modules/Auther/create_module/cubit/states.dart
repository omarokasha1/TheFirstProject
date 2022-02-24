
import '../../../../models/module_model.dart';

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