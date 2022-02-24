
import '../../../../models/module_model.dart';

abstract class CreateAssignmentStates {}

class InitCreateAssignmentState extends CreateAssignmentStates {}

class ChangeItemStateAssignment extends CreateAssignmentStates {}

class CreateNewAssignmentLoadingState extends CreateAssignmentStates {}

class CreateNewAssignmentSuccssesState extends CreateAssignmentStates {

  final CreateContent createContentModel;
  CreateNewAssignmentSuccssesState(this.createContentModel);
}

class CreateNewAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  CreateNewAssignmentErrorState(this.error);
}
class GetNewAssignmentLoadingState extends CreateAssignmentStates {}

class GetNewAssignmentSuccssesState extends CreateAssignmentStates {

  final CreateContent createContentModel;
  GetNewAssignmentSuccssesState(this.createContentModel);
}

class GetNewAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  GetNewAssignmentErrorState(this.error);
}
class ChangeActivityStateAssignment extends CreateAssignmentStates {}