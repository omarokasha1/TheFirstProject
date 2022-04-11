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
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:open_file/open_file.dart';

import 'cubit/cubit.dart';
import 'cubit/statues.dart';

class CreateTrackScreen extends StatelessWidget {
  CreateTrackScreen({Key? key}) : super(key: key);

  File? file;
  dynamic filePath;

  var result;
  TextEditingController trackNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  //TextEditingController durationController = TextEditingController();
  Duration? duration;

  File? trackImage;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthorCoursesCubit>(context)..getAuthorCoursesPublishedData();
    return BlocProvider.value(
      value: BlocProvider.of<CreateTrackCubit>(context)..myActivities=[],
      child: BlocConsumer<CreateTrackCubit, CreateTrackStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CreateTrackCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: BlocProvider.of<AuthorCoursesCubit>(context).coursesModelPublish != null,
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height / 10 + 150,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.elliptical(400, 150),
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, top: 10),
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
                          const SafeArea(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 40, top: 100),
                                child: Text("Create Track",
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
                                      prefixIcon:
                                          Icons.drive_file_rename_outline,
                                      onChanged: (moduleName) {
                                        print(moduleName);
                                        cubit.onCourseNameChanged(moduleName);
                                      },
                                    ),

                                    customTextFormFieldWidget(
                                      state: TextInputAction.done,
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
                                    //         //  color: primaryColor,
                                    //         ),
                                    //     focusedBorder: OutlineInputBorder(
                                    //       borderSide: const BorderSide(
                                    //         color: primaryColor,
                                    //       ),
                                    //       borderRadius:
                                    //           BorderRadius.circular(10.0),
                                    //     ),
                                    //     border: OutlineInputBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
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
                                    //           inherit: false,
                                    //           color: primaryColor),
                                    //       title: const Text('Select duration'),
                                    //       selectedTextStyle:
                                    //           TextStyle(color: primaryColor),
                                    //       onConfirm:
                                    //           (Picker picker, List<int> value) {
                                    //         // You get your duration here
                                    //         duration = Duration(
                                    //             hours: picker
                                    //                 .getSelectedValues()[0],
                                    //             minutes: picker
                                    //                 .getSelectedValues()[1]);
                                    //       },
                                    //     ).showDialog(context).then((value) {
                                    //       print(value);
                                    //       durationController.text =
                                    //           '${duration!.inHours.toString()} Hours ${(duration!.inHours * 60 - duration!.inMinutes)} Minutes';
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
                                        //print('value is ${value}');
                                      },
                                      validate: (value) {
                                        if (value == null ||
                                            value.length == 0) {
                                          return 'Please select one or more Courses';
                                        }
                                        return null;
                                      },
                                      dataSource: BlocProvider.of<AuthorCoursesCubit>(context).coursesList,
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
                                            result = await FilePicker.platform.pickFiles();
                                            if (result != null) {
                                              file = File(result!.files.single.path!);
                                              filePath = result!.files.first;
                                              print(
                                                  "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
                                            } else {
                                              print('no image selected');
                                            }
                                          },
                                          child:  Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.0),
                                            child: filePath == null ?  Text(
                                              "Upload",
                                              style: TextStyle(fontSize: 20),
                                            ): viewFileDetails() ,
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
                                        text: 'Save',
                                        onPressed: () async {
                                          //print(trackImage);
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            if (file == null) {
                                              showToast(
                                                  message: "No Image Selected",
                                                  color: Colors.red);
                                            } else {
                                              await cubit.createNewTrack(
                                                trackName: trackNameController.text,
                                                shortDescription: shortDescriptionController.text,
                                                //duration: durationController.text,
                                                courses: cubit.myActivities,
                                                trackImage: file,
                                              )
                                                  .then((value) {
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
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget viewFileDetails() {
    final kb = filePath.size / 1024;
    final mb = kb / 1024;
    final fileSize =
    mb > 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} Kb";
    final extension = filePath.extension ?? "none";

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),

          child: InkWell(
            onTap: () {
              OpenFile.open(filePath.path);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: primaryColor,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    filePath.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ".${filePath.extension}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "/ $fileSize",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: secondaryColor,
            radius: 20.0,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              color: Colors.white,
              iconSize: 20.0,
              onPressed: () async {
                result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  file = File(result!.files.single.path!);
                  filePath = result!.files.first;

                }
              },
            ),
          ),
        ),
      ],
    );
  }

}
