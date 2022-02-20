import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/Auther/create_track/cubit/statues.dart';
enum Sequences { ordered, unordered }

class CreateTrackCubit extends Cubit<CreateTrackStates> {
  CreateTrackCubit() : super(InitCreateTrackState());

  static CreateTrackCubit get(context) => BlocProvider.of(context);

  List? myActivities = [];
  String myActivitiesResult = '';
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


}