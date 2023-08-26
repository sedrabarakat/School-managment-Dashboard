import 'package:dio/dio.dart';

String baseUrl = 'http://localhost:8000/api/';

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers:{
          'Accept':'application/json',
          'Content-Type':'application/json'
        },
        connectTimeout:const Duration(  seconds: 60),
        receiveTimeout:  const Duration(  seconds: 60),
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async
  {
    dio!.options.headers =
    {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'??'',
    };
    return await dio!.get(
      url,
      queryParameters: query,
      data: data
    );
  }

  static Future<Response> postData({
    required String url,
    Map<dynamic, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {
      dio!.options.headers =
      {
        'Accept': 'application/json',
        'Authorization' : 'Bearer ${token}'??'',
      };

      return dio!.post(
        url,
        queryParameters: query,
        data: data,
      );
    }

  static Future<Response> postDataImage({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
    ProgressCallback? onSendProgress,
  }) async
  {
    dio!.options.headers =
    {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'??'',
    };
    return dio!.post(
      url,
      onSendProgress: onSendProgress,
      queryParameters: query,
      data: data,
    );
  }

  static Future downloadFile({
    required String url,
    required String savePath,
    required Map<String, dynamic> query,
    required String token,
  }) async {
    try {
      await dio.download(
        url,
        savePath,
        queryParameters: query,
        options: Options(
          headers: <String, dynamic>{'Authorization': 'Bearer $token'??''},
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

}
