import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? q,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: q,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? q,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: q,
    );
  }

  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? q,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio!.delete(
      url,
      data: data,
      queryParameters: q,
    );
  }
}
