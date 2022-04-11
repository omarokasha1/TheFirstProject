import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/states.dart';
import 'package:open_file/open_file.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';

class CreateCourseScreen extends StatelessWidget {
  CreateCourseScreen({Key? key}) : super(key: key);

 // File? courseImage;
  File? file;
 // FilePickerResult? result;

  dynamic filePath;
  var picker = ImagePicker();
    var result;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController requiermentController = TextEditingController();
  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CreateAssignmentCubit>(context)..getAssignmentData();
    return BlocProvider.value(
      value: BlocProvider.of<CreateModuleCubit>(context)..getModulesData()..contentActivities=[]..assignmentActivities =[],
      child: BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
        listener: (context, state) {},
        builder: (context, state) => BlocConsumer<CreateModuleCubit, CreateModuleStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var courseCubit = AuthorCoursesCubit.get(context);
            var moduleCubit = CreateModuleCubit.get(context);
            return Scaffold(
              body: ConditionalBuilder(
                condition: moduleCubit.getContent != null && BlocProvider.of<CreateAssignmentCubit>(context).assignments != null,
                builder: (context){
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
                                  )),
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
                                  child: Text("Create Course",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white)),
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
                                      customTextFormFieldWidget(
                                        onChanged: (courseName) {
                                          courseCubit
                                              .onCourseNameChanged(courseName);
                                        },
                                        controller: courseNameController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Module Name Must Be Not Empty';
                                          } else if (!courseCubit.hasCourseName) {
                                            return 'please, enter a valid Module Name';
                                          }
                                          return null;
                                        },
                                        label: "Course Name",
                                        type: TextInputType.text,
                                        prefix: true,
                                        prefixIcon:
                                        Icons.drive_file_rename_outline,
                                      ),
                                      customTextFormFieldWidget(
                                        onChanged: (moduleName) {
                                          courseCubit
                                              .onCourseNameChanged(moduleName);
                                        },
                                        controller: shortDescriptionController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Description Must Be Not Empty';
                                          } else if (!courseCubit.hasCourseName) {
                                            return 'please, enter a valid Description';
                                          }
                                          return null;
                                        },
                                        label: "Short Description",
                                        type: TextInputType.text,
                                        prefix: true,
                                        prefixIcon: Icons.description_outlined,
                                      ),
                                      customTextFormFieldWidget(
                                        state: TextInputAction.done,
                                        controller: requiermentController,
                                        validate: (value) {
                                          return null;
                                        },
                                        label: "Requirements",
                                        type: TextInputType.text,
                                        prefix: true,
                                        prefixIcon: Icons.list,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 40.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text("Modules",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.grey[600])),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            selectMoreItem(
                                              dataSource: moduleCubit.contentList,
                                              name: "Content",
                                              myActivities:
                                              moduleCubit.contentActivities,
                                              onSaved: (value) {
                                                print(value);
                                                if (value == null) return;
                                                moduleCubit.changeContentActivity(value);
                                              },
                                              validate: (value) {
                                                if (value == null ||
                                                    value.length == 0) {
                                                  return 'Please select one or more Courses';
                                                }
                                                return null;
                                              },
                                            ),
                                            selectMoreItem(
                                              name: "Assignment",
                                              validate: (value) {
                                                return null;
                                              },
                                              myActivities:
                                              moduleCubit.assignmentActivities,
                                              onSaved: (value) {
                                                if (value == null) return;
                                                // setState(() {
                                                //   myActivities = value;
                                                // });
                                                moduleCubit.changeAssignmentActivity(value);
                                              },
                                              dataSource: BlocProvider.of<CreateAssignmentCubit>(context).assignmentList,
                                            ),
                                            selectMoreItem(
                                              name: "Quiz",
                                              validate: (value) {
                                                return null;
                                              },
                                              myActivities:
                                              moduleCubit.contentActivities,
                                              onSaved: (value) {
                                                if (value == null) return;
                                                // setState(() {
                                                //   myActivities = value;
                                                // });
                                                //moduleCubit.changeContentActivity(value);
                                              },
                                              dataSource: [],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text("Language",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.grey[600])),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: primaryColor,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                          ),
                                          value: courseCubit.selectedItem,
                                          elevation: 16,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   selectedItem = newValue!;
                                            // });
                                            courseCubit.changeItem(newValue!);
                                          },
                                          itemHeight: 50,
                                          items: courseCubit.items
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text("Course Image",
                                            style: TextStyle(
                                                fontSize: 25, color: Colors.grey[600])),
                                      ),
                                      Center(
                                        child: TextButton(
                                            onPressed: () async {
                                              result = await FilePicker.platform.pickFiles();

                                              if (result != null) {
                                                file = File(result!.files.single.path!);
                                                filePath = result!.files.first;
                                                print(result!.files.single.path!);
                                                print(result!.files.first);
                                                //   cubit.uploadFile(file!);
                                              } else {
                                                showToast(
                                                    message:
                                                    "upload file must be not empty");
                                              }
                                              moduleCubit.selectImage();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: filePath == null
                                                  ? Text(
                                                "Upload",
                                                style: TextStyle(fontSize: 20),
                                              )
                                                  : viewFileDetails(),
                                            )),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 8.0),
                                      //   child: Text("Course Image",
                                      //       style: TextStyle(
                                      //           fontSize: 25, color: Colors.grey[600])),
                                      // ),
                                      // Center(
                                      //   child: TextButton(
                                      //       onPressed: () async {
                                      //         result = await picker.pickImage(source: ImageSource.gallery);
                                      //         if (result != null) {
                                      //           file = File(result.path);
                                      //         } else {
                                      //           print('no image selected');
                                      //         }
                                      //         //image = await _picker.pickImage(source: ImageSource.gallery);
                                      //         print(
                                      //             "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
                                      //       },
                                      //       child: Padding(
                                      //         padding: EdgeInsets.symmetric(
                                      //             horizontal: 22.0),
                                      //         child: filePath == null ?
                                      //         Text(
                                      //           "Upload",
                                      //           style: TextStyle(fontSize: 20),
                                      //         ):viewFileDetails(moduleCubit),
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 10, right: 10, bottom: 10),
                                child: defaultButton(
                                  text: 'Save',
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (file == null) {
                                        showToast(
                                            message:
                                            "Course Image Must be Not empty",
                                        color: Colors.red);
                                      } else {
                                        courseCubit.createNewCourse(
                                          courseName: courseNameController.text,
                                          shortDescription: shortDescriptionController.text,
                                          requirements: requiermentController.text,
                                          contents: moduleCubit.contentActivities,
                                          assignments: moduleCubit.assignmentActivities,
                                          language: courseCubit.selectedItem,
                                          courseImage: file,
                                        ).then((value) => Navigator.pop(context));
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
                  );
                },
                fallback: (context){
                  return const Center(child: CircularProgressIndicator(),);
                },
              ),
            );
          },
        ),
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
          padding: const EdgeInsets.all(12),

          child: InkWell(
            onTap: () {
              OpenFile.open(filePath.path);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: primaryColor,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    filePath.name,
                    style: const TextStyle(
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
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "/ $fileSize",
                        style: const TextStyle(fontSize: 20),
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

