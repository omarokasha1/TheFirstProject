import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms/modules/profile/profile_cubit/cubit.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
        // baseUrl: "https://lms-ap.herokuapp.com/",
        //baseUrl: "https://wikitoexcelapi.herokuapp.com/",
        receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Content-Type': 'application/json',
          //'lang':'en'
        },
      ),
    );
  }

  //This Methos to upload Files Using HTTP
  static upload(File imageFile, context) async {
    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://10.5.62.214:8080/api/user/upload");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('profile', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.headers['x-auth-token'] = userToken!;
    request.files.add(multipartFile);
    ProfileCubit.get(context).getUserProfile();

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //This Methos to upload Files Using DIO
  static void uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    print(file.path);
    FormData formData = FormData.fromMap({
      'profile': await MultipartFile.fromFile(file.path,
          filename: fileName,
          contentType: MediaType("image", fileName.split(".").last))
    });
    await DioHelper.postData(
            url: uploadImageProfile2, data: {
      'profile' : await fileUpload(file)
    } ,files: true, token: userToken)
        .then((value) => print('value ${value}'))
        .catchError((onError) {
      print('error ${onError}');
    });
    // Response response = await dio.post(uploadImageProfile2, data: formData, options: Options(
    //   headers: {
    //     'x-auth-token': userToken ?? '',
    //     'accept':'*/*',
    //     'Content-Type': 'multipart/form-data',
    //   }
    // ));
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
    bool files = false,
    String? token,
  }) async {
    dio.options.headers = {
      'x-auth-token': token ?? '',
      //'Content-Type': 'multipart/form-data',
      'accept': '*/*',
      //'Content-Type': 'multipart/form-data',
    };
    if(files){
      FormData formData = FormData.fromMap(
          data,
      );
      return await dio.post(url, data: formData);
    }else{
      return await dio.post(url, data: data);
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'x-auth-token': token ?? '',
      //'Content-Type': 'application/json',
    };
    if(files){
      FormData formData = FormData.fromMap(
        data,
      );
      return await dio.put(
        url,
        data: formData,
      );
    }else{
      return await dio.put(
        url,
        data: data,
      );
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'x-auth-token': userToken,
      'Content-Type': 'application/json',
    };
    return dio
        .delete(
      url,
    )
        .catchError((error) {
      print("DIO ERROR $error");
    });
  }
}
