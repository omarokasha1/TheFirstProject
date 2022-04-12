
import 'package:lms/models/assignment_model.dart';
import 'package:lms/models/response_model.dart';


abstract class CreateAssignmentStates {}

class InitCreateAssignmentState extends CreateAssignmentStates {}

class ChangeItemState extends CreateAssignmentStates {}
class ChangeAActivityState extends CreateAssignmentStates {}
class SelectImageState extends CreateAssignmentStates {}

class CreateNewAssignmentLoadingState extends CreateAssignmentStates {}

class CreateNewAssignmentSuccssesState extends CreateAssignmentStates {

  final AssignmentsModel createAssignmentsModel;
  CreateNewAssignmentSuccssesState(this.createAssignmentsModel);
}

class CreateNewAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  CreateNewAssignmentErrorState(this.error);
}
class GetAssignmentsLoadingState extends CreateAssignmentStates {}

class GetAssignmentsSuccssesState extends CreateAssignmentStates {

  final AssignmentsModel createContentModel;
  GetAssignmentsSuccssesState(this.createContentModel);
}

class GetAssignmentsErrorState extends CreateAssignmentStates {
  final String error;
  GetAssignmentsErrorState(this.error);
}

class UpdateAssignmentLoadingState extends CreateAssignmentStates {}

class UpdateAssignmentSuccssesState extends CreateAssignmentStates {

  final ResponseModel  responseModel;
  UpdateAssignmentSuccssesState(this.responseModel);
}

class UpdateAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  UpdateAssignmentErrorState(this.error);
}
class DeleteAssignmentLoadingState extends CreateAssignmentStates {}

class DeleteAssignmentSuccssesState extends CreateAssignmentStates {

  final ResponseModel responseModel;
  DeleteAssignmentSuccssesState(this.responseModel);
}

class DeleteAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  DeleteAssignmentErrorState(this.error);
}