import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/api/dio_interceptor/logging_interceptor.dart';
import 'package:vinemas_v1/core/api/dio_interceptor/token_interceptor.dart';
import 'package:vinemas_v1/core/config/app_url.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    initDio();
  }

  void initDio() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: AppUrl.apiHost + AppUrl.versionApi,
      receiveTimeout: Duration(seconds: 8),
      connectTimeout: Duration(seconds: 8),
    );
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(TokenInterceptor());
  }
}
