import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';

//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.

        //baseUrl: "https://lms-ap.herokuapp.com/",
        baseUrl: "http://10.5.62.214:8081/",
        receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Content-Type': 'application/json',
          //'lang':'en'
        },
      ),
    );
  }

  static void uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    await DioHelper.postData(url:uploadImageProfile, data: {
        //'profile': await MultipartFile.fromFile(file.path, filename: fileName,contentType: MediaType("image", fileName.split(".").last))
      'profile':file
        }
        ,token: userToken).then((value) => print('value ${value}')).catchError((onError){print('error ${onError}');});
    //print('here :::::: ${response.data['id']}');
    //print('here 2 :::::: ${response.data.toString()}');
    //return response.data['id'];
  }


  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.
  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    dio.options.headers = {
      'x-auth-token': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
    );
  }

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'x-auth-token': token ?? '',
      //'Content-Type': 'multipart/form-data',
    };

    return await dio.post(url, data: data);
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'x-auth-token': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.put(
      url,
      data: data,
    );
  }

  static Future<Response> pushFile() async{
    var formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
    });
    var response = await dio.post('/info', data: formData);
    return response;
  }
}
