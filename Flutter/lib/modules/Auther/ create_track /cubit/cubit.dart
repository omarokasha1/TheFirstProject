import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/%20create_track%20/cubit/statues.dart';
enum Sequences { ordered, unordered }

class CreateTrackCubit extends Cubit<CreateTrackStates> {
  CreateTrackCubit() : super(InitCreateTrackState());

  static CreateTrackCubit get(context) => BlocProvider.of(context);

  bool hasTrackName = false;
  var formKey = GlobalKey<FormState>();

  Sequences? character = Sequences.ordered;
  onCourseNameChanged(String name) {
    hasTrackName = false;
    if (name.length > 2) {
      hasTrackName = true;
    }
  }
  saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      myActivitiesResult = myActivities.toString();
    }
  }
  changeRadio (Sequences? value) {
    character = value;
  }

  bool checkedValue = false;
  List? myActivities = [];
  String myActivitiesResult = '';
  void changeActivity(value)
  {
    myActivities=value;
    emit(ChangeActivityState());
  }


}