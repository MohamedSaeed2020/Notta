import 'package:dio/dio.dart';
import 'package:notes/core/network/remote/api_constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.method = "GET";
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    dio.options.method = "POST";
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
    );
  }
}
