import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/modules/Auther/create_module/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_module/cubit/states.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import '../../courses/cubit/states.dart';

class UpdateCourseScreen extends StatelessWidget {
  final Courses courseModel;
  UpdateCourseScreen(this.courseModel, {Key? key}) : super(key: key);

  File? courseImage;
  var picker = ImagePicker();

  TextEditingController courseNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    courseNameController.text = courseModel.title ?? '';
    shortDescriptionController.text = courseModel.description ?? '';
    requirementController.text = courseModel.requirements ?? '';
    CreateModuleCubit.get(context).myActivities = courseModel.contents;

    return BlocProvider.value(
      value: BlocProvider.of<CreateModuleCubit>(context)..getModulesData(),
      child: BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
        listener: (context, state) {},
        builder: (context, state) => BlocConsumer<CreateModuleCubit, CreateModuleStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var courseCubit = AuthorCoursesCubit.get(context);
            var moduleCubit = CreateModuleCubit.get(context);
            return Scaffold(
              body: ConditionalBuilder(
                condition: moduleCubit.getModuleModel != null,
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
                                  const EdgeInsets.only(left: 40, top: 100),
                                  child: Text("Update Course",
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
                                        controller: requirementController,
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
                                              dataSource: moduleCubit.list,
                                              name: "Content",
                                              myActivities:
                                              moduleCubit.myActivities,
                                              onSaved: (value) {
                                                print(value);
                                                if (value == null) return;
                                                moduleCubit.changeActivity(value);
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
                                              myActivities: [],
                                              //moduleCubit.myActivities,
                                              onSaved: (value) {
                                                if (value == null) return;
                                                // setState(() {
                                                //   myActivities = value;
                                                // });
                                                //moduleCubit.changeActivity(value);
                                              },
                                              dataSource: [],
                                            ),
                                            selectMoreItem(
                                              name: "Quiz",
                                              validate: (value) {
                                                return null;
                                              },
                                              myActivities: [],
                                              //moduleCubit.myActivities,
                                              onSaved: (value) {
                                                if (value == null) return;
                                                // setState(() {
                                                //   myActivities = value;
                                                // });
                                                //moduleCubit.changeActivity(value);
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
                                                fontSize: 25,
                                                color: Colors.grey[600])),
                                      ),
                                      Center(
                                        child: TextButton(
                                            onPressed: () async {
                                              final pickedFile =
                                              await picker.pickImage(
                                                  source:
                                                  ImageSource.gallery);
                                              if (pickedFile != null) {
                                                courseImage =
                                                    File(pickedFile.path);
                                              } else {
                                                print('no image selected');
                                              }
                                              //image = await _picker.pickImage(source: ImageSource.gallery);
                                              print(
                                                  "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
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
                                      if (courseImage == null) {
                                        showToast(
                                            message:
                                            "Course Image Must be Not empty",
                                        color: Colors.red);
                                      } else {
                                        courseCubit.updateCourse(
                                          courseName: courseNameController.text,
                                          shortDescription: shortDescriptionController.text,
                                          requirements: requirementController.text,
                                          contents: moduleCubit.myActivities!,
                                          language: courseCubit.selectedItem,
                                          courseImage: courseImage,
                                          sID : courseModel.sId,
                                        ).then((value) {
                                          moduleCubit.myActivities = [];
                                          Navigator.pop(context);
                                        });
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
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
