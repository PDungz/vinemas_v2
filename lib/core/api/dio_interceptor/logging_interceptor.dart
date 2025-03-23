import 'package:dio/dio.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';

/// A custom interceptor for logging API requests, responses, and errors.
class LoggingInterceptor extends Interceptor {
  /// Logs the request details before sending it to the server.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printI('[API]-[REQUEST]'
        '\nURL: ${options.baseUrl}${options.path}'
        '\nMethod: ${options.method}'
        '\nHeaders: ${options.headers}'
        '\nQuery Params: ${options.queryParameters}'
        '\nRequest Data: ${options.data}');
    super.onRequest(options, handler);
  }

  /// Logs the response details after receiving a response from the server.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printS('[API]-[RESPONSE]'
        '\nStatus Code: ${response.statusCode}'
        '\nURL: ${response.requestOptions.baseUrl}${response.requestOptions.path}'
        '\nMethod: ${response.requestOptions.method}'
        '\nQuery Params: ${response.requestOptions.queryParameters}'
        '\nResponse Data: ${response.data}');
    super.onResponse(response, handler);
  }

  /// Logs the error details when an API call fails.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printE('[API]-[ERROR]'
        '\nStatus Code: ${err.response?.statusCode}'
        '\nURL: ${err.requestOptions.baseUrl}${err.requestOptions.path}'
        '\nMethod: ${err.requestOptions.method}'
        '\nError Data: ${err.response?.data}'
        '\nError Message: ${err.message}');
    super.onError(err, handler);
    return handler.next(err);
  }
}
