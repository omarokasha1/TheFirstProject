import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import '../../../../models/new/courses_model.dart';
import '../module_view.dart';

class UpdateAssignment extends StatelessWidget {
  final Assignment model;

  UpdateAssignment(this.model, {Key? key}) : super(key: key);

  Duration? duration;

  FilePickerResult? result;
  TextEditingController moduleNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  dynamic filePath;
  String dropdownValue = "City";
  File? file;

  @override
  Widget build(BuildContext context) {
    moduleNameController.text = model.assignmentTitle ?? '';
    shortDescriptionController.text = model.description ?? '';
    durationController.text = model.assignmentDuration ?? '';
    return BlocConsumer<AssignmentCubit, CreateAssignmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AssignmentCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
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
                    const SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, top: 100),
                          child: Text("Update Assignment",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.w),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 30,
                              ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              customTextFormFieldWidget(
                                onChanged: (moduleName) {
                                  print(moduleName);
                                  cubit.onModuleNameChanged(moduleName);
                                },
                                controller: moduleNameController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Assignment Name Must Be Not Empty';
                                  } else if (!cubit.hasModuleName) {
                                    return 'please, enter a valid Assignment Name';
                                  }
                                  return null;
                                },
                                label: "Assignment Name",
                                type: TextInputType.text,
                                prefix: true,
                                prefixIcon: Icons.drive_file_rename_outline,
                              ),
                              customTextFormFieldWidget(
                                state: TextInputAction.done,
                                onChanged: (moduleName) {
                                  cubit.onModuleNameChanged(moduleName);
                                },
                                controller: shortDescriptionController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Description Must Be Not Empty';
                                  } else if (!cubit.hasModuleName) {
                                    return 'please, enter a valid Description';
                                  }
                                  return null;
                                },
                                label: "Short Description",
                                type: TextInputType.text,
                                prefix: true,
                                prefixIcon: Icons.description_outlined,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.timer),
                                  labelText: "Duration",
                                  labelStyle: const TextStyle(
                                      //  color: primaryColor,
                                      ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onTap: () {
                                  Picker(
                                    adapter: NumberPickerAdapter(
                                        data: <NumberPickerColumn>[
                                          const NumberPickerColumn(
                                              begin: 0,
                                              end: 100,
                                              suffix: Text(' hr')),
                                          const NumberPickerColumn(
                                              begin: 0,
                                              end: 59,
                                              suffix: Text(' min')),
                                        ]),
                                    delimiter: <PickerDelimiter>[
                                      PickerDelimiter(
                                        child: Container(
                                          width: 20.0,
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.more_vert),
                                        ),
                                      )
                                    ],
                                    hideHeader: true,
                                    confirmText: 'OK',
                                    confirmTextStyle: const TextStyle(
                                        inherit: false, color: primaryColor),
                                    title: const Text('Select duration'),
                                    selectedTextStyle:
                                        const TextStyle(color: primaryColor),
                                    onConfirm:
                                        (Picker picker, List<int> value) {
                                      // You get your duration here
                                      duration = Duration(
                                          hours: picker.getSelectedValues()[0],
                                          minutes:
                                              picker.getSelectedValues()[1]);
                                    },
                                  ).showDialog(context).then((value) {
                                    print(value);
                                    durationController.text =
                                        '${duration!.inHours.toString()} Hours ${(duration!.inHours * 60 - duration!.inMinutes)} Minutes';
                                  });
                                },
                                controller: durationController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Content",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.grey[600])),
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () async {
                                      result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        file = File(result!.files.single.path!);
                                        filePath = result!.files.first;
                                      } else {
                                        showToast(
                                            message:
                                                "upload file must be not empty");
                                      }
                                      cubit.selectImage();
                                      print(
                                          "filePath herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr>>>>> ${filePath.path}");
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      child: filePath == null
                                          ? Text(
                                              "Upload",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          : viewFileDetails(cubit, result,filePath,file),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 10, right: 10, bottom: 10),
                        child: defaultButton(
                          text: 'Save',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (result == null) {
                                showToast(message: "content must be not empty");
                              } else {
                                cubit
                                    .updateAssignmentData(
                                      moduleName: moduleNameController.text,
                                      description:
                                          shortDescriptionController.text,
                                      duration: durationController.text,
                                      file: file!,
                                      moduleId: model.sId!,
                                    )
                                    .then((value) => Navigator.pop(context));
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
