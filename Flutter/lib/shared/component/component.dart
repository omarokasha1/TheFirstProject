import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/courses/course_overview_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../../modules/courses/course_details_screen.dart';

// Widget for Buttons
Widget defaultButton({
  required Function onPressed,
  required String text,
  bool color = true,
  Widget? widget,
}) =>
    Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: color ? null : Border.all(color: primaryColor, width: 2),
        gradient: color
            ? gradientColor(one: primaryColor, two: secondaryColor)
            : gradientColor(one: Colors.white, two: Colors.white),
      ),
      child: Center(
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: widget != null
                  ? widget
                  : Text(
                      text,
                      style: TextStyle(
                        color: color ? Colors.white : primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );

//Widget for TextFormField  For Auth
Widget customTextFormFieldAuth({
  required TextEditingController controller,
  required String label,
  bool obSecure = false,
  IconData? prefixIcon,
  bool prefix = false,
  IconData? suffixIcon,
  bool suffix = false,
  Function? onPressed,
  required String? Function(String?) validate,
  TextInputType type = TextInputType.text,
  int maxDigit = 100,
  Function? onChanged,
  TextInputAction? state = TextInputAction.next,
}) {
  return TextFormField(
    textInputAction: state,
    onChanged: (value) {
      onChanged!(value);
    },
    // validator: (s) {
    //
    //   if (s!.trim().isEmpty) {
    //     return error;
    //   }
    //    validate(s);
    // },

    validator: (value) {
      return validate(value);
    },
    controller: controller,
    obscureText: obSecure,
    cursorColor: primaryColor,
    keyboardType: type,
    decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefix
          ? Icon(
              prefixIcon,
              color: Colors.grey,
              size: 23.h,
            )
          : null,
      suffixIcon: suffix
          ? IconButton(
              icon: Icon(
                suffixIcon,
                color: Colors.grey,
                size: 23.h,
              ),
              onPressed: () {
                onPressed!();
              },
            )
          : null,
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 15.sp,
      ),
    ),
    inputFormatters: [
      LengthLimitingTextInputFormatter(maxDigit),
    ],
    //maxLength: maxDigit,
  );
}

Widget customTextFormFieldWidget({
  required TextEditingController controller,
  required String label,
  required String? Function(String?) validate,
  TextInputType type = TextInputType.text,
  Function? onChanged,
  IconData? prefixIcon,
  bool prefix = false,
  bool? colorPerfix,
  TextInputFormatter? textInputFormatter,
  bool textInput = false,
  Function? onTab,
  TextInputAction? state = TextInputAction.next,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      textInputAction: state,
      onChanged: (value) {
        onChanged != null ? onChanged(value) : null;
      },
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorPerfix != null ? primaryColor : null,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: prefix
            ? Icon(
                prefixIcon,
                color: colorPerfix != null ? primaryColor : null,
                size: 20.h,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputFormatters: <TextInputFormatter>[
        if (textInput) textInputFormatter!,
      ],
      validator: (value) {
        return validate(value);
      },
      onTap: () {
        onTab != null ? onTab() : null;
      },
    ),
  );
}

Future<bool?> showToast({required String message, Color color = Colors.green}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0.sp,
  );
}

void navigatorAndRemove(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

void navigator(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget buildCourseItem(context, bool enroll, Courses? courseModel) =>
    InkWell(
      onTap: () {
        navigator(
            context,
            enroll
                ? CoursesDetailsScreen(courseModel!)
                : CoursesOverViewScreen(courseModel!));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.6, 1.2), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: imageFromNetwork(
                            url:

                                //'https://img-c.udemycdn.com/course/240x135/3446572_346e_2.jpg'
                                '${courseModel!.imageUrl}'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12.0.w, right: 12.w, top: 5.h, bottom: 5.h),
                        margin: EdgeInsets.all(11.0.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${courseModel.contents!.length} Modules',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //'Complete Instagram Marketing Course'
                      '${courseModel.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(

                              //'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'
                              '${courseModel.author!.imageUrl}'),
                          radius: 16.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Created by ${courseModel.author!.userName}',
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/star.png',width: 20,height: 20,),
                              SizedBox(
                                width: 5.w,
                              ),
                              //Text('${courseModel.review}'),
                              Text('${courseModel.review ?? ''}',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


Widget builtTrackContant(context) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Stack',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '10 Courses',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 8,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: grayText,
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('60% Complete')
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );

Widget imageFromNetwork(
    {required String url,
    fit = BoxFit.cover,
    double height = double.infinity,
    double width = double.infinity}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    fit: fit,
    height: height,
    width: width,
  );
}

Widget offline(child) {
  return Stack(
    fit: StackFit.expand,
    children: [
      child,
      Positioned(
        left: 0.0,
        right: 0.0,
        height: 32.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: connected != true ? secondaryColor : null,
          child: connected != true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "No connection",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 12.0,
                      height: 12.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    ],
  );
}

Widget selectMoreItem(
    {required String name,
    required validate,
    required List? myActivities,
    required onSaved,
    required List? dataSource}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MultiSelectFormField(
      autovalidate: AutovalidateMode.disabled,
      chipBackGroundColor: secondaryColor,
      chipLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
      //  checkBoxActiveColor: Colors.blue,
      checkBoxCheckColor: Colors.white,
      dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Text(
        name,
        style: TextStyle(fontSize: 16),
      ),
      validator: (value) {
        return validate(value);
      },
      dataSource: dataSource,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintWidget: const Text('Please choose one or more Course'),
      initialValue: myActivities,
      onSaved: (value) {
        //print("skmdjsnhdbcshbcbshcnjsmccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc $value");
        onSaved(value);
      },
    ),
  );
}
dynamic fileUpload(File file) async {
  String fileName = file.path.split('/').last;
  return await MultipartFile.fromFile(
    file.path,
    filename: fileName,
    contentType: MediaType("image", fileName.split(".").last),
  );
}
Widget emptyPage({required String text,required context})
{
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/empty.json',
              width: MediaQuery.of(context).size.width / 1),
          Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
