import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/create_track/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_track/cubit/statues.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';

class CreateTrackScreen extends StatefulWidget {
  CreateTrackScreen({Key? key}) : super(key: key);

  @override
  State<CreateTrackScreen> createState() => _CreateTrackScreenState();
}

class _CreateTrackScreenState extends State<CreateTrackScreen> {
  TextEditingController trackNameController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  Duration? duration;

  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateTrackCubit(),
      child: BlocConsumer<CreateTrackCubit, CreateTrackStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CreateTrackCubit.get(context);
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
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              customTextFormFieldWidget(
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
                              ),
                              TextFormField(
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Duration ',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 15.sp,
                                  ),
                                ),
                                onTap: () {
                                  Picker(
                                    adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                                      const NumberPickerColumn(begin: 0, end: 100, suffix: Text(' hr')),
                                      const NumberPickerColumn(begin: 0, end: 59, suffix: Text(' min')),
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
                                    confirmTextStyle: TextStyle(inherit: false, color: primaryColor),
                                    title: const Text('Select duration'),
                                    selectedTextStyle: TextStyle(color: Colors.blue),
                                    onConfirm: (Picker picker, List<int> value) {
                                      // You get your duration here
                                      duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
                                    },
                                  ).showDialog(context).then((value) {
                                    print(value);
                                    durationController.text = '${duration!.inHours.toString()} Hours ${(duration!.inHours*60 - duration!.inMinutes)} Minutes';
                                  });
                                },
                                controller:durationController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.w),
                                child: MultiSelectFormField(
                                  autovalidate: AutovalidateMode.disabled,
                                  chipBackGroundColor:secondaryColor,
                                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                                  checkBoxActiveColor: Colors.blue,
                                  checkBoxCheckColor: Colors.white,
                                  dialogShapeBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                  title: Text(
                                    "My Courses*",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'Please select one or more Courses';
                                    }
                                    return null;
                                  },
                                  dataSource: [
                                    {
                                      "display": "Flutter",
                                      "value": "Flutter",
                                    },
                                    {
                                      "display": "Dart",
                                      "value": "Dart",
                                    },
                                    {
                                      "display": "C++",
                                      "value": "C++",
                                    },
                                    {
                                      "display": "Java",
                                      "value": "Java",
                                    },
                                  ],
                                  textField: 'display',
                                  valueField: 'value',
                                  okButtonLabel: 'OK',
                                  cancelButtonLabel: 'CANCEL',
                                  hintWidget: const Text('Please choose one or more Course'),
                                  initialValue: cubit.myActivities,
                                  onSaved: (value) {
                                    if (value == null) return;
                                    setState(() {
                                     cubit.myActivities = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                ElevatedButton(
                                  child: const Text('Cancel'),
                                  onPressed: (){},
                                ),
                                ElevatedButton(
                                  child: const Text('Save'),
                                  onPressed: cubit.saveForm,
                                ),
                              ],),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )));
        },
      ),
    );
  }
}
