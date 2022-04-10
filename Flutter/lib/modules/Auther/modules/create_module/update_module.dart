import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import '../../../../models/new/contents_model.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class UpdateModule extends StatelessWidget {
  final Contents contentModel;

  UpdateModule(this.contentModel, {Key? key}) : super(key: key);

  Duration? duration;

  FilePickerResult? result;
  TextEditingController moduleNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  String? filePath;
  String dropdownValue = "City";
  File? file;

  @override
  Widget build(BuildContext context) {
    moduleNameController.text = contentModel.contentTitle ?? '';
    shortDescriptionController.text = contentModel.description ?? '';
    durationController.text = contentModel.contentDuration ?? '';
    //moduleTypeController.text = contentModel.enumType ?? '';
    return BlocConsumer<CreateModuleCubit, CreateModuleStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CreateModuleCubit.get(context);
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
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, top: 100),
                          child: Text("Update Modules",
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
                                    return 'Module Name Must Be Not Empty';
                                  } else if (!cubit.hasModuleName) {
                                    return 'please, enter a valid Module Name';
                                  }
                                  return null;
                                },
                                label: "Module Name",
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
                                  prefixIcon: Icon(Icons.timer),
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
                                          child: Icon(Icons.more_vert),
                                        ),
                                      )
                                    ],
                                    hideHeader: true,
                                    confirmText: 'OK',
                                    confirmTextStyle: TextStyle(
                                        inherit: false, color: primaryColor),
                                    title: const Text('Select duration'),
                                    selectedTextStyle:
                                        TextStyle(color: primaryColor),
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
                                        file!.openRead();
                                        filePath = file!.path;
                                        //  cubit.uploadFile(file!);
                                      } else {
                                        showToast(
                                            message:
                                                "upload file must be not empty");
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0),
                                      child: Text(
                                        filePath == null ? "Upload" : filePath!,
                                        style: TextStyle(fontSize: 20),
                                      ),
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
                            text: 'Update',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (result == null) {
                                  showToast(
                                      message: "content must be not empty");
                                }
                                if (filePath != null) {
                                  // //var r = JSON.stringify();
                                  // print(filePath);
                                  //  print(file!.uri.data);
                                  // print(cubit.formData!.files.single.value);
                                  //print(cubit.formData!.files.single.runtimeType);
                                  // cubit.createNewModule(moduleName: moduleNameController.text, description: shortDescriptionController.text, duration: durationController.text,content:cubit.formData);
                                  cubit.updateNewModule(
                                    moduleId: contentModel.sId,
                                    moduleName: moduleNameController.text,
                                    description: shortDescriptionController.text,
                                    duration: durationController.text,
                                    image: file,
                                    //moduleType: contentModel.contentType.toString(),
                                  );
                                  Navigator.pop(context);
                                } else {}
                                //        cubit.createNewModule(moduleName: moduleNameController.text, description: shortDescriptionController.text, duration: durationController.text, moduleType: moduleTypeController.text,content:"https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg");

                              }
                            }),
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
