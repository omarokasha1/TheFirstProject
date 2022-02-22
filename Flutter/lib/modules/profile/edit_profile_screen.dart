import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/user.dart';
import 'package:lms/modules/authertication/login/login_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/profile_screen.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:material_tag_editor/tag_editor.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key, this.type, this.image}) : super(key: key);

  var bioController = TextEditingController();
  var phoneController = TextEditingController();
bool check =true;
  //var genderController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var birthdayController = TextEditingController();
  var facultyController = TextEditingController();
  var universityController = TextEditingController();
  var majorController = TextEditingController();
  var gradeController = TextEditingController();
  var experienceController = TextEditingController();
  var interestedController = TextEditingController();

  List<String> items = ['Male', 'Female'];
  String? selectedItem;

  final List<Widget> myTabs = [
    const Tab(text: 'Personal Information'),
    const Tab(text: 'Educational Information'),
  ];

  final ImagePicker _picker = ImagePicker();

  // Pick an image
  final type;
  XFile? image;

  File? profileImage;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is UpdadteProfileSuccessState) {
          navigatorAndRemove(context, ProfileScreen());
        }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Layout(
          widget: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                backgroundColor: primaryColor,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.model != null && cubit.model!.profile != null,
                builder: (context) {
                  bioController.text = cubit.model!.profile!.bio!;
                  phoneController.text = cubit.model!.profile!.phone!;
                  //genderController.text = cubit.model!.profile!.gender!;
                  selectedItem = cubit.model!.profile!.gender!;
                  //print(selectedItem);
                  cityController.text = cubit.model!.profile!.city!;
                  countryController.text = cubit.model!.profile!.country!;
                  birthdayController.text = cubit.model!.profile!.birthDay!;
                  facultyController.text =
                      cubit.model!.profile!.userEducation!.faculty!;
                  universityController.text =
                      cubit.model!.profile!.userEducation!.university!;
                  majorController.text =
                      cubit.model!.profile!.userEducation!.major!;
                  for(int i=0;i<cubit.gradeItems.length&&check;i++)
                    {
                      if(cubit.model!.profile!.userEducation!.grade! == cubit.gradeItems[i]){
                        cubit.selectedItemGrade = cubit.model!.profile!.userEducation!.grade!;
                        check=false;
                        break;
                      }
                    }
                  if(cubit.selectedItemGrade == null && check){
                    cubit.changeSelectedItemGrade('GPA');
                    gradeController.text =
                    cubit.model!.profile!.userEducation!.grade!;
                    check=false;
                  }
                  experienceController.text =
                      cubit.model!.profile!.userEducation!.experince!;
                  //interestedController.text = cubit.model!.profile!.userEducation!.interest!.join(" ");
                  cubit.interestedItems =
                      cubit.model!.profile!.userEducation!.interest;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 45.0,
                        backgroundImage: CachedNetworkImageProvider(
                          '${cubit.model!.profile!.imageUrl}',
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: CircleAvatar(
                            radius: 16.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 15.0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                ),
                                color: Colors.white,
                                iconSize: 15.0,
                                onPressed: () async {
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    profileImage = File(pickedFile.path);
                                  } else {
                                    print('no image selected');
                                  }
                                  //image = await _picker.pickImage(source: ImageSource.gallery);
                                  print(
                                      'hereeeeee ${profileImage!.uri.toString()}');
                                  print(
                                      "Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        //"Kareem Ahmed Helmy",
                        "${cubit.model!.profile!.userName}",
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "${cubit.model!.profile!.bio}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: primaryColor,
                                indicatorColor: primaryColor,
                                unselectedLabelColor: Colors.black,
                                isScrollable: true,
                                tabs: myTabs,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TabBarView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      PersonalInformation(
                                          context, birthdayController),
                                      EducationalInformation(cubit),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: defaultButton(
                                  onPressed: () {
                                    cubit.updateUserProfile(
                                      phone: phoneController.text,
                                      birthday: birthdayController.text,
                                      city: cityController.text,
                                      country: countryController.text,
                                      gender: selectedItem,
                                      //imageUrl: cubit.model!.profile!.imageUrl,
                                      bio: bioController.text,
                                      university: universityController.text,
                                      major: majorController.text,
                                      faculty: facultyController.text,
                                      grade: cubit.selectedItemGrade == 'GPA' ? gradeController.text : cubit.selectedItemGrade,
                                      experience: experienceController.text,
                                      // interest:
                                      //     interestedController.text.split(" "),
                                      interest: cubit.interestedItems,
                                    );
                                  },
                                  text: "Save",
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget PersonalInformation(context, dateController) {
    return ListView(
      shrinkWrap: true,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Bio',
          controller: bioController,
          prefixIcon: Icons.perm_device_information_outlined,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Bio";
            }
            return null;
          },
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Phone',
          controller: phoneController,
          prefixIcon: Icons.perm_device_information_outlined,
          type: TextInputType.number,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Phone";
            }
            return null;
          },
          textInput: true,
          textInputFormatter: LengthLimitingTextInputFormatter(11),
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Gender',
              labelStyle: const TextStyle(
                color: primaryColor,
              ),
              focusColor: primaryColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
              prefixIcon: const Icon(
                Icons.person,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: selectedItem,
            elevation: 16,
            onChanged: (newValue) {
              selectedItem = newValue!;
            },
            itemHeight: 50,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'City',
          controller: cityController,
          prefixIcon: Icons.location_city_outlined,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your City";
            }
            return null;
          },
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Country',
          controller: countryController,
          prefixIcon: Icons.account_balance_rounded,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Country";
            }
            return null;
          },
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Birthday',
          controller: birthdayController,
          prefixIcon: Icons.account_balance_rounded,
          type: TextInputType.none,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Birthday";
            }
            return null;
          },
          onTab: () {
            showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.parse('${DateTime.now().year - 10}-12-01'),
                    firstDate:
                        DateTime.parse('${DateTime.now().year - 50}-01-01'),
                    lastDate:
                        DateTime.parse('${DateTime.now().year - 10}-31-12'))
                .then(
              (value) {
                birthdayController.text = DateFormat.yMMMd().format(value!);
              },
            );
          },
        ),
      ],
    );
  }

  Widget EducationalInformation(ProfileCubit cubit) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Faculty',
          controller: facultyController,
          prefixIcon: Icons.art_track_rounded,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Faculty";
            }
            return null;
          },
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'University',
          controller: universityController,
          prefixIcon: Icons.account_balance_rounded,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your University";
            }
            return null;
          },
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Major',
          controller: majorController,
          prefixIcon: Icons.wysiwyg_rounded,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Major";
            }
            return null;
          },
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Grade',
              labelStyle: const TextStyle(
                color: primaryColor,
              ),
              focusColor: primaryColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
              prefixIcon: const Icon(
                Icons.grade_rounded,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: cubit.selectedItemGrade,
            elevation: 16,
            onChanged: (newValue) {
              cubit.changeSelectedItemGrade(newValue!);
              print('Grade change ${cubit.selectedItemGrade}');
            },
            itemHeight: 50,
            items: cubit.gradeItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20,),
        cubit.selectedItemGrade != null && cubit.selectedItemGrade == 'GPA'?
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'GPA',
          controller: gradeController,
          prefixIcon: Icons.grade_rounded,
          type: TextInputType.number,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your GPA";
            }
            return null;
          },
          textInput: true,
          textInputFormatter: FilteringTextInputFormatter.allow(
            RegExp(r'^[1-4]|\.(\d?\d?)'),
          ),
        ) : Container(),
        const SizedBox(
          height: 10.0,
        ),
        customTextFormFieldWidget(
          colorPerfix: true,
          label: 'Experience',
          controller: experienceController,
          prefixIcon: Icons.work_outline_rounded,
          type: TextInputType.text,
          prefix: true,
          validate: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Experience";
            }
            return null;
          },
        ),
        TagEditor(
          length: cubit.interestedItems.length,
          delimiters: [',', ' '],
          hasAddButton: true,
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'interested...',
          ),
          onTagChanged: (newValue) {
            //SetState
            cubit.addInterestedItem(newValue);
          },
          tagBuilder: (context, index) => _Chip(
            index: index,
            label: cubit.interestedItems[index],
            onDeleted: (index) {
              //SetState
              cubit.deleteInterestedItem(index);
            },
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
