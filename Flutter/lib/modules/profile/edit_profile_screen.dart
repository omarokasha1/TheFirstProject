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
                  cityController.text = cubit.model!.profile!.city!;
                  countryController.text = cubit.model!.profile!.country!;
                  birthdayController.text = cubit.model!.profile!.birthDay!;
                  facultyController.text =
                      cubit.model!.profile!.userEducation!.faculty!;
                  universityController.text =
                      cubit.model!.profile!.userEducation!.university!;
                  majorController.text =
                      cubit.model!.profile!.userEducation!.major!;
                  gradeController.text =
                      cubit.model!.profile!.userEducation!.grade!;
                  experienceController.text =
                      cubit.model!.profile!.userEducation!.experince!;
                  interestedController.text =
                      cubit.model!.profile!.userEducation!.interest!.join(" ");
                  cubit.interestedItems = cubit.model!.profile!.userEducation!.interest;
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
                                      grade: gradeController.text,
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
                  child:  CircularProgressIndicator(),
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
        // customTextFormFieldWidget(
        //   label: 'Bio',
        //   controller: bioController,
        //   prefixIcon: Icons.perm_device_information_outlined,
        //   type: TextInputType.text,
        //   prefix: true,
        //   validate: (value){
        //     if (value!.isEmpty) {
        //       return "Please, Enter your Bio";
        //     }
        //     return null;
        //   }
        // ),
        TextFormField(
          controller: bioController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Bio',
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.perm_device_information_outlined,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Bio";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Phone',
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.phone,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Phone";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
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
        const SizedBox(
          height: 10.0,
        ),
        // TextFormField(
        //   controller: genderController,
        //   keyboardType: TextInputType.text,
        //   cursorColor: primaryColor,
        //   decoration: InputDecoration(
        //     labelText: 'Gender',
        //     labelStyle: TextStyle(
        //       color: primaryColor,
        //     ),
        //     focusColor: primaryColor,
        //     focusedBorder: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: primaryColor,
        //         width: 2.0,
        //       ),
        //     ),
        //     prefixIcon: Icon(
        //       Icons.person,
        //       color: primaryColor,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return "Please, Enter your Gender";
        //     }
        //     return null;
        //   },
        // ),
        // SizedBox(
        //   height: 10.0,
        // ),
        TextFormField(
          controller: cityController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'City',
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
              Icons.location_city_outlined,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your City";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: countryController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Country',
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
              Icons.account_balance_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Country";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: birthdayController,
          keyboardType: TextInputType.none,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Birthday',
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
              Icons.today_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Birthday";
            }
            return null;
          },
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.parse('${DateTime.now().year - 10}-01-01'),
                    firstDate:
                        DateTime.parse('${DateTime.now().year - 70}-01-01'),
                    lastDate:
                        DateTime.parse('${DateTime.now().year - 10}-01-01'))
                .then(
              (value) {
                birthdayController.text = DateFormat.yMMMd().format(value!);
              },
            );
          },
        ),
        const SizedBox(
          height: 10.0,
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
        TextFormField(
          controller: facultyController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Faculty',
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.art_track_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Faculty";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: universityController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'University',
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.account_balance_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your University";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: majorController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Major',
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
              Icons.wysiwyg_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Major";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: gradeController,
          keyboardType: TextInputType.number,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(RegExp('[[1-9].[0-9][0-9]]')),
          // ],
          cursorColor: primaryColor,
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
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Grade";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: experienceController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Experience',
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
              Icons.work_outline_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Experience";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        // TextFormField(
        //   controller: interestedController,
        //   keyboardType: TextInputType.text,
        //   cursorColor: primaryColor,
        //   decoration: InputDecoration(
        //     labelText: 'interested',
        //     labelStyle: TextStyle(
        //       color: primaryColor,
        //     ),
        //     focusColor: primaryColor,
        //     focusedBorder: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: primaryColor,
        //         width: 2.0,
        //       ),
        //     ),
        //     prefixIcon: Icon(
        //       Icons.import_contacts_rounded,
        //       color: primaryColor,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return "Please, Enter your interested";
        //     }
        //     return null;
        //   },
        // ),
        // SizedBox(
        //   height: 10.0,
        // ),
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