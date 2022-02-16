import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateCourseScreen extends StatefulWidget {
  CreateCourseScreen({Key? key}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  TextEditingController courseNameController = TextEditingController();

  TextEditingController shortDescriptionController = TextEditingController();


  TextEditingController requiermentController = TextEditingController();

  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List<String> items = ['Arabic', 'English', 'Italy', 'french'];
  String selectedItem = "Arabic";

  bool checkedValue=false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateCourseCubit(),
      child: BlocConsumer<CreateCourseCubit, CreateCourseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CreateCourseCubit.get(context);
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
                      )
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
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Create Course",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey[600])),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                customTextFormFieldWidget(
                                  onChanged: (courseName) {
                                    cubit.onCourseNameChanged(courseName);
                                  },
                                  controller: courseNameController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Module Name Must Be Not Empty';
                                    } else if (!cubit.hasCourseName) {
                                      return 'please, enter a valid Module Name';
                                    }
                                    return null;
                                  },
                                  label: "Course Name",
                                  type: TextInputType.text,
                                  prefix: true,
                                  prefixIcon: Icons.drive_file_rename_outline,
                                ),
                                customTextFormFieldWidget(
                                  onChanged: (moduleName) {
                                    cubit.onCourseNameChanged(moduleName);
                                  },
                                  controller: shortDescriptionController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Description Must Be Not Empty';
                                    } else if (!cubit.hasCourseName) {
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
                                  controller: requiermentController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Requirement Must Be Not Empty';
                                    }
                                    return null;
                                  },
                                  label: "Requirements",
                                  type: TextInputType.text,
                                  prefix: true,
                                  prefixIcon: Icons.list,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text("Modules",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.grey[600])),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      customTextFormFieldWidget(

                                        controller: courseNameController,
                                        validate: (value) {

                                          return null;
                                        },
                                        label: "Content",
                                        type: TextInputType.text,
                                      ),
                                      customTextFormFieldWidget(

                                        controller: shortDescriptionController,
                                        validate: (value) {
                                          return null;
                                        },
                                        label: "Assignment",
                                        type: TextInputType.text,
                                      ),
                                      customTextFormFieldWidget(
                                        controller: requiermentController,
                                        validate: (value) {

                                          return null;
                                        },
                                        label: "Quiz",
                                        type: TextInputType.text,
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
                                SizedBox(
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    value: selectedItem,
                                    elevation: 16,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedItem = newValue!;
                                      });
                                    },
                                    itemHeight: 50,
                                    items: items.map<DropdownMenuItem<String>>(
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
                                      onPressed: () {},
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
                        CheckboxListTile(
                          title:const  Text("you agree to sent request to admin",style: TextStyle(fontSize: 15),),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10, bottom: 10),
                          child: defaultButton(
                              text: 'Save',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {}
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
      ),
    );
  }
}
