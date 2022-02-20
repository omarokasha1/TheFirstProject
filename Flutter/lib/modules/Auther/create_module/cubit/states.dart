
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