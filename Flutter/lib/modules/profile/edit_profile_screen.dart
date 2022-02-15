import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/user.dart';
import 'package:lms/modules/authertication/login/login_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/profile_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var birthdayController = TextEditingController();
  var facultyController = TextEditingController();
  var universityController = TextEditingController();
  var majorController = TextEditingController();
  var gradeController = TextEditingController();
  var experienceController = TextEditingController();
  var interestedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
       if(state is UpdadteProfileSuccessState){
         navigatorAndRemove(
             context, ProfileScreen());
       }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);

        return Layout(
          widget: Scaffold(
            backgroundColor: primaryColor,
            appBar:  AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: (){
                  Navigator.pop(context);
                },

              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.model!=null&&cubit.model!.profile != null,

              builder:(context)
              {
                bioController.text = cubit.model!.profile!.bio!;
                phoneController.text = cubit.model!.profile!.phone!;
                genderController.text = cubit.model!.profile!.gender!;
                cityController.text = cubit.model!.profile!.city!;
                countryController.text = cubit.model!.profile!.country!;
                birthdayController.text = cubit.model!.profile!.birthDay!;
                facultyController.text = cubit.model!.profile!.userEducation!.faculty!;
                universityController.text = cubit.model!.profile!.userEducation!.university!;
                majorController.text = cubit.model!.profile!.userEducation!.major!;
                gradeController.text = cubit.model!.profile!.userEducation!.grade!;
                experienceController.text = cubit.model!.profile!.userEducation!.experince!;
                interestedController.text = cubit.model!.profile!.userEducation!.interest!.join(" ");
              return  Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 45.0,
                          backgroundImage:
                          CachedNetworkImageProvider(
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
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                  color: Colors.white,
                                  iconSize: 15.0,
                                  onPressed: () {
                                    print("Pic");
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          //"Kareem Ahmed Helmy",
                          "${cubit.model!.profile!.userName}",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "${cubit.model!.profile!.bio}",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50.0),
                            ),
                            color: Colors.white,
                          ),
                          child: DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: TabBar(
                                      labelColor: primaryColor,
                                      indicatorColor: Colors.teal[200],
                                      unselectedLabelColor: Colors.black,
                                      isScrollable: true,
                                      tabs: [
                                        Tab(text: 'Personal Information'),
                                        Tab(text: 'Educational Information'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: TabBarView(
                                      children: [
                                        PersonalhInformation(
                                            context, birthdayController),
                                        EducationalInformation(),
                                      ],
                                    ),
                                  ),
                                  defaultButton(
                                    onPressed: () {
                                      cubit.updateUserProfile(
                                        phone: phoneController.text,
                                        birthday: birthdayController.text,
                                        city: cityController.text,
                                        country: countryController.text,
                                        gender: genderController.text,
                                        imageUrl:
                                            cubit.model!.profile!.imageUrl,
                                        bio: bioController.text,
                                        university: universityController.text,
                                        major: majorController.text,
                                        faculty: facultyController.text,
                                        grade: gradeController.text,
                                        experience: experienceController.text,
                                        interest: interestedController.text
                                            .split(" "),
                                      );
                                    },
                                    text: "Save",
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ),
          ),
        );
      },
    );
  }

  Widget PersonalhInformation(context, dateController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: bioController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Bio',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Phone',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: genderController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Gender',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your Gender";
            }
            return null;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: cityController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'City',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: countryController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Country',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: birthdayController,
          keyboardType: TextInputType.none,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Birthday',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
                    initialDate: DateTime.parse('${DateTime.now().year -10}-01-01'),
                    firstDate:
                        DateTime.parse('${DateTime.now().year - 70}-01-01'),
                    lastDate:
                        DateTime.parse('${DateTime.now().year -10}-01-01'))
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

  Widget EducationalInformation() {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: facultyController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Faculty',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: universityController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'University',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: majorController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Major',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
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
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: experienceController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'Experience',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
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
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: interestedController,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            labelText: 'interested',
            labelStyle: TextStyle(
              color: primaryColor,
            ),
            focusColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
              Icons.import_contacts_rounded,
              color: primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please, Enter your interested";
            }
            return null;
          },
        ),
      ],
    );
  }
}
