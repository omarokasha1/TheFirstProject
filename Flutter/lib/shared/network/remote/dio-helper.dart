import 'package:dio/dio.dart';

//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.

       // baseUrl: "https://lms-ap.herokuapp.com/",
        baseUrl: "http://10.5.62.214:8081/",
        // baseUrl: "https://lms-ap.herokuapp.com/",
        receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Content-Type': 'application/json',
          //'lang':'en'
        },
      ),
    );
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
      'Content-Type': 'application/json',
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
}
