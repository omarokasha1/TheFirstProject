import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/courses/course_overview_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:http_parser/http_parser.dart';
import '../../modules/courses/course_details_screen.dart';

// Widget for Buttons
Widget defaultButton({
  required Function onPressed,
  required String text,
  bool color = true,
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
              child: Text(
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
}) {
  return TextFormField(
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
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: TextFormField(

      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
        //  color: primaryColor,
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
         // color: Colors.grey,
          size: 20.h,
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        return validate(value);
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

Widget buildCourseItem(context, bool enroll, CourseModel courseModel) =>
    InkWell(
      onTap: () {
        navigator(
            context,
            enroll
                ? CoursesDetailsScreen(courseModel)
                : CoursesOverViewScreen(courseModel));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
          width: 300.w,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,

                offset: Offset(0.0, 1.0), //(x,y)

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
                                '${courseModel.imageUrl}'),
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
                          '14 Videos',
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
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 20.h),
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
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text('${courseModel.review}'),
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

Widget buildCourseItems(context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://www.incimages.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '14 Videos',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instagram Marketing Course',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Created by Kelvin'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3),
                        decoration: BoxDecoration(
                          color: gray,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('4.5'),
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
dynamic fileUpload(File file) async {
  String fileName = file.path.split('/').last;
  return await MultipartFile.fromFile(
    file.path,
    filename: fileName,
    contentType: MediaType("image", fileName.split(".").last),
  );
}