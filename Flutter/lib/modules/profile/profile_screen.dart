import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/home/home_screen.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/modules/profile/edit_profile_screen.dart';
import 'package:lms/modules/splash_screen.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/component/zoomDrawer.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  File? profileImage;
  var picker = ImagePicker();
  var formKey = GlobalKey<FormState>();

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ProfileCubit>(context)..getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Layout(
            widget: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                backgroundColor: primaryColor,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              floatingActionButton: IconButton(
                iconSize: 50.0,
                onPressed: () {
                  //print("button");
                  navigator(context, EditProfileScreen());
                },
                icon: CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 50.0.r,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
              body: ConditionalBuilder(
                condition: cubit.model != null && cubit.model!.profile != null,
                builder: (context) => Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                  color: Colors.white,
                                  iconSize: 15.0,
                                  onPressed: () async {
                                    // File? image;
                                    // var imagePicker = await ImagePicker.pickImage2(source: ImageSource.gallery);
                                    // if(imagePicker != null){
                                    //   //SetState
                                    //   image = imagePicker as File;
                                    // }
                                    // try{
                                    //   String fileName = image!.path.split('/').last;
                                    //   FormData formData = FormData.fromMap({
                                    //     'profile': await MultipartFile.fromFile(image.path, filename: fileName),
                                    //     //contentType: MediaType('image', 'png')),
                                    //   });
                                    // }catch(e){
                                    //   print(e);
                                    // }
                                    File? imageFile;
                                    var base64Imageteam;
                                    final GlobalKey<FormState> _formKey =
                                        GlobalKey<FormState>();
                                    /// Get from gallery
                                    getFromGallery() async {
                                      PickedFile? pickedFile =
                                          await ImagePicker().getImage(
                                        source: ImageSource.gallery,
                                        //maxWidth: 1800,
                                        //maxHeight: 1800,
                                      );
                                      if (pickedFile != null) {
                                        //setState(() {
                                        imageFile = File(pickedFile.path);
                                        print(
                                            "imageFile----------------------------->$imageFile");
                                        List<int> imageBytes =
                                            imageFile!.readAsBytesSync();
                                        base64Imageteam =
                                            base64Encode(imageBytes);

                                        print(imageFile!.runtimeType);

                                        // FTPConnect ftpConnect = FTPConnect('http://10.5.62.214/upload',port: 8080,user:'backend', pass:'backend123');
                                        // File fileToUpload = imageFile!;
                                        // await ftpConnect.connect();
                                        // bool res = await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
                                        // await ftpConnect.disconnect();
                                        // print(res);
                                        //print(base64Imageteam);
                                        //DioHelper.postData(url: uploadImageProfile, data: {'profile':imageFile},token: userToken);
                                        //DioHelper.upload(imageFile!, context);
                                        //DioHelper.uploadImage(!);
                                        cubit.updateUserProfileImage(imageUrl: imageFile);
                                        // updatimge(base64Image, id);
                                        //});
                                      }
                                    }
                                    /// Get from File
                                    getFromFile() async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        imageFile =
                                            File(result.files.single.path!);
                                        print(
                                            "File----------------------------->$imageFile");
                                        //DioHelper.uploadImage(imageFile!);
                                        //List<int> fileBytes = imageFile!.readAsBytesSync();
                                        //base64Imageteam = base64Encode(fileBytes);
                                        //print(base64Imageteam);
                                        //print(imageFile!.path);
                                      } else {
                                        // User canceled the picker
                                      }
                                    }

                                    await getFromGallery();
                                    //cubit.getUserProfile();
                                    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                    // if (pickedFile != null) {
                                    //   profileImage = File(pickedFile.path);
                                    //   DioHelper.uploadImage(profileImage!);
                                    //   cubit.getUserProfile();
                                    //   //print(profileImage!.path.split('/').last);
                                    // } else {
                                    //   print('no image selected');
                                    // }
                                    //image = await _picker.pickImage(source: ImageSource.gallery);
                                    //print("Piiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiic");
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
                        // Text(
                        //   "${cubit.model!.profile!.bio}",
                        //   style: TextStyle(
                        //     fontSize: 16.0,
                        //     color: Colors.grey[300],
                        //   ),
                        // ),
                        if (userView == 'user' && userType == 'user')
                          TextButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure want be become a Author ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                cubit.becomeAuthorRequest();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
                                              text: 'No',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                                //   btnOkOnPress: () {},
                              ).show();
                            },
                            child: Text(
                              "Become an Author",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[300],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        if (userView == 'author' && userType == 'author')
                          TextButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch User ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(key: "userView",value: "user");
                                                userType = CacheHelper.get(key: 'userType');
                                                navigatorAndRemove(context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
                                              text: 'No',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                                //   btnOkOnPress: () {},
                              ).show();
                            },
                            child: Text(
                              "Switch to User",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[300],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        if (userView == 'user' && userType == 'author')
                          TextButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure to Switch Author ?',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              text: 'Yes, I\'m Agree',
                                              onPressed: () {
                                                CacheHelper.put(key: "userView",value: "author");
                                                userType = CacheHelper.get(key: 'userType');
                                                navigatorAndRemove(context, SplashScreen());
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            child: defaultButton(
                                              color: false,
                                              text: 'No',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                                //   btnOkOnPress: () {},
                              ).show();
                            },
                            child: Text(
                              "Switch to Author",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[300],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  leading: Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Personal",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(),
                                Text(
                                  "${cubit.model!.profile!.email}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "Phone",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.phone}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "Gender",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.gender}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "City",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      "${cubit.model!.profile!.city} ",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    Text(
                                      "${cubit.model!.profile!.country}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   "Country",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),

                                // Text(
                                //   "Birthday",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.birthDay}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  leading: Icon(
                                    Icons.science_rounded,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Educational",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(),
                                // Text(
                                //   "Faculty",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${cubit.model!.profile!.userEducation!.faculty}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "University",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.userEducation!.university}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "Major",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.userEducation!.major}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Row(
                                  children: [
                                    // Text(
                                    //   "Grade",
                                    //   style: TextStyle(
                                    //     fontSize: 20.sp,
                                    //     color: primaryColor,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    //SizedBox(width: 10,),
                                    Text(
                                      "Grade ${cubit.model!.profile!.userEducation!.grade}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  leading: Icon(
                                    Icons.work_outline_rounded,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Experience",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(),
                                // Text(
                                //   "Experience",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  "${cubit.model!.profile!.userEducation!.experince}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                  ),
                                ),
                                // Text(
                                //   "Interested",
                                //   style: TextStyle(
                                //     fontSize: 16.sp,
                                //     color: primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  leading: Icon(
                                    Icons.import_contacts_rounded,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Interested",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                // Text(
                                //   "${cubit.model!.profile!.userEducation!.interest!.join(" ")}",
                                //   style: TextStyle(
                                //     fontSize: 20.sp,
                                //   ),
                                // ),
                                // Container(
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     //scrollDirection: Axis.horizontal,
                                //     itemBuilder: (context, index) =>
                                //         buildInterestItem(cubit.model!.profile!
                                //             .userEducation!.interest![index]),
                                //     itemCount: cubit.model!.profile!
                                //         .userEducation!.interest!.length,
                                //   ),
                                // ),
                                Wrap(
                                  spacing: 8.0, // gap between adjacent chips
                                  runSpacing: 4.0, // gap between lines
                                  //direction: Axis.vertical,
                                  children: List.generate(
                                      cubit.model!.profile!.userEducation!
                                          .interest!.length,
                                      (index) => buildInterestItem(
                                          '${cubit.model!.profile!.userEducation!.interest![index]}')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInterestItem(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    );
    // return Chip(
    //   avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('JL')),
    //   label: Text('Laurens'),
    // );
  }
}
