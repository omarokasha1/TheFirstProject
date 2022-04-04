import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/models/track_model.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/statues.dart';

class UpdateTrackScreen extends StatelessWidget {
  final Tracks modelTrack;
  UpdateTrackScreen(this.modelTrack, {Key? key}) : super(key: key);


  TextEditingController trackNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  File? trackImage;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    trackNameController.text = modelTrack.trackName ?? '';
    shortDescriptionController.text = modelTrack.description ?? '';
    //CreateTrackCubit.get(context).myActivities=modelTrack.courses;

    return BlocConsumer<CreateTrackCubit, CreateTrackStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CreateTrackCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.coursesModel != null,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 10 + 150,
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.elliptical(400, 150),
                              )),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20, top: 10),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40, top: 100),
                              child: Text("Update Track",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            child: Form(
                              key: cubit.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  customTextFormFieldWidget(
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Track Name Must Be Not Empty';
                                      } else if (!cubit.hasTrackName) {
                                        return 'please, enter a valid Track Name';
                                      }
                                      return null;
                                    },
                                    controller: trackNameController,
                                    label: 'Track Name*',
                                    type: TextInputType.text,
                                    prefix: true,
                                    prefixIcon: Icons.drive_file_rename_outline,
                                    onChanged: (moduleName) {
                                      print(moduleName);
                                      cubit.onCourseNameChanged(moduleName);
                                    },
                                  ),

                                  customTextFormFieldWidget(
                                    onChanged: (moduleName) {
                                      print(moduleName);
                                      cubit.onCourseNameChanged(moduleName);
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Description Must Be Not Empty';
                                      } else if (!cubit.hasTrackName) {
                                        return 'please, enter a valid Description';
                                      }
                                      return null;
                                    },
                                    controller: shortDescriptionController,
                                    label: 'Short Description*',
                                    type: TextInputType.text,
                                    prefix: true,
                                    prefixIcon: Icons.description_outlined,
                                  ),
                                  // TextFormField(
                                  //   keyboardType: TextInputType.none,
                                  //   decoration: InputDecoration(
                                  //     labelText: "Duration",
                                  //     prefixIcon: Icon(Icons.timer),
                                  //     labelStyle: const TextStyle(
                                  //       //  color: primaryColor,
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: const BorderSide(
                                  //         color: primaryColor,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(20),
                                  //     ),
                                  //   ),
                                  //   onTap: () {
                                  //     Picker(
                                  //       adapter: NumberPickerAdapter(
                                  //           data: <NumberPickerColumn>[
                                  //             const NumberPickerColumn(
                                  //                 begin: 0,
                                  //                 end: 100,
                                  //                 suffix: Text(' hr')),
                                  //             const NumberPickerColumn(
                                  //                 begin: 0,
                                  //                 end: 59,
                                  //                 suffix: Text(' min')),
                                  //           ]),
                                  //       delimiter: <PickerDelimiter>[
                                  //         PickerDelimiter(
                                  //           child: Container(
                                  //             width: 20.0,
                                  //             alignment: Alignment.center,
                                  //             child: Icon(Icons.more_vert),
                                  //           ),
                                  //         )
                                  //       ],
                                  //       hideHeader: true,
                                  //       confirmText: 'OK',
                                  //       confirmTextStyle: TextStyle(
                                  //           inherit: false, color: primaryColor),
                                  //       title: const Text('Select duration'),
                                  //       selectedTextStyle:
                                  //       TextStyle(color: primaryColor),
                                  //       onConfirm:
                                  //           (Picker picker, List<int> value) {
                                  //         // You get your duration here
                                  //         duration = Duration(
                                  //             hours:
                                  //             picker.getSelectedValues()[0],
                                  //             minutes:
                                  //             picker.getSelectedValues()[1]);
                                  //       },
                                  //     ).showDialog(context).then((value) {
                                  //       print(value);
                                  //       durationController.text =
                                  //       '${duration!.inHours.toString()} Hours ${(duration!.inHours * 60 - duration!.inMinutes)} Minutes';
                                  //     });
                                  //   },
                                  //   controller: durationController,
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  selectMoreItem(
                                    name: "My Courses",
                                    myActivities: cubit.myActivities,
                                    onSaved: (value) {
                                      if (value == null) return;
                                      // setState(() {
                                      //   myActivities = value;
                                      // });
                                      cubit.changeActivity(value);
                                    },
                                    validate: (value) {
                                      if (value == null || value.length == 0) {
                                        return 'Please select one or more Courses';
                                      }
                                      return null;
                                    },
                                    dataSource: cubit.list,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Track Image",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.grey[600])),
                                  ),
                                  Center(
                                    child: TextButton(
                                        onPressed: () async {
                                          final pickedFile =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            trackImage = File(pickedFile.path);
                                            print(trackImage!);
                                            print(
                                                "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
                                          } else {
                                            print('no image selected');
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22.0),
                                          child: Text(
                                            "Upload",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )),
                                  ),
                                  // Row(children: [
                                  //   ListTile(
                                  //     title: const Text('Ordered'),
                                  //     leading: Radio<Sequences>(
                                  //       value: Sequences.ordered,
                                  //       groupValue: cubit.character,
                                  //       onChanged:(value){cubit.changeRadio(value);},
                                  //     ),
                                  //   ),
                                  //
                                  // ],),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: defaultButton(
                                      text: 'Update',
                                      onPressed: () async {
                                        //print(trackImage);
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          if (trackImage == null) {
                                            showToast(
                                                message: "No Image Selected",
                                                color: Colors.red);
                                          } else {
                                            await cubit.updateTrackData(
                                                trackName: trackNameController.text,
                                                shortDescription: shortDescriptionController.text,
                                                courses: cubit.myActivities,
                                                trackImage: trackImage,
                                                sID: modelTrack.sId).then((value) {
                                                cubit.myActivities = [];
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}
