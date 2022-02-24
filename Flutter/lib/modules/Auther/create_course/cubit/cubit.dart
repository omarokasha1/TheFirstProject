
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_course/cubit/states.dart';

class CreateCourseCubit extends Cubit<CreateCourseStates> {
  CreateCourseCubit() : super(InitCreateCourseState());

  static CreateCourseCubit get(context) => BlocProvider.of(context);

  bool hasCourseName = false;

  onCourseNameChanged(String name) {
    hasCourseName = false;
    if (name.length > 2) {
      hasCourseName = true;
    }
  }


  bool checkedValue = false;


  List<String> items = ['Content', 'Assignment'];
  String selectedItem = "Content";

  void changeItem(String value)
  {
    selectedItem=value;
    emit(ChangeItemState());
  }



}
