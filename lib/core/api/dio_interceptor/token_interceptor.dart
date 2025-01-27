import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/config/app_url.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add the token to the request headers
    options.headers['Authorization'] = 'Bearer ${AppUrl.apiKey}';
    return handler.next(options);
  }
}
