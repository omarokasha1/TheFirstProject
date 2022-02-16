import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateModuleScreen extends StatefulWidget {
  CreateModuleScreen({Key? key}) : super(key: key);

  @override
  State<CreateModuleScreen> createState() => _CreateModuleScreenState();
}

class _CreateModuleScreenState extends State<CreateModuleScreen> {
  List<String> items = ['Content', 'Assignment', 'Quiz'];
  String selectedItem = "Content";
  TextEditingController moduleNameController = TextEditingController();

  TextEditingController shortDescriptionController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController moduleTypeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String dropdownValue = "City";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateModuleCubit(),
      child: BlocConsumer<CreateModuleCubit, CreateModuleStates>(
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 80),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: secondaryColor, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child:      Center(
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      "Upload",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  )),
                            ),
                          ),
                        ),
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
                                  height: 60,
                                ),

                                Padding(
                                  padding:const  EdgeInsets.only(left: 8.0),
                                  child:  Text("Create Module",style: TextStyle(fontSize: 25,color: Colors.grey[600])),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                customTextFormFieldWidget(
                                  onChanged: (moduleName) {
                                    cubit.onModuleNameChanged(moduleName);
                                  },
                                  controller: moduleNameController,
//error: "User Name Must Be Not Empty",
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
                                  onChanged: (moduleName) {
                                    cubit.onModuleNameChanged(moduleName);
                                  },
                                  controller: shortDescriptionController,
//error: "User Name Must Be Not Empty",
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
                                customTextFormFieldWidget(
// onChanged: (moduleName) {
//   cubit.onModuleNameChanged(moduleName);
// },
                                  controller: durationController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Duration Must Be Not Empty';
                                    }
                                    return null;
                                  },
                                  label: "Duration",
                                  type: TextInputType.text,
                                  prefix: true,
                                  prefixIcon: Icons.access_time,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Module Type",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey[600])),
                                ),
                                SizedBox(height: 25,),
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
                                    itemHeight:50 ,
                                    items: items.map<DropdownMenuItem<String>>(

                                        (String value) {

                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10,bottom: 10),
                          child: defaultButton(
                              text: 'Save',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {

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
      ),
    );
  }
}
