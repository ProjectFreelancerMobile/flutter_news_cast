// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

import '../../utils/log_data.dart';

class RestClient {
  static const TIMEOUT = 30000;
  static const ENABLE_LOG = false;

  // singleton
  static final RestClient instance = new RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  late String baseUrl;

  void init(String baseUrl, {String? accessToken}) {
    this.baseUrl = baseUrl;
  }

  static Dio getDio({String? customUrl}) {
    var dio = Dio(instance.getDioBaseOption(customUrl: customUrl));
    if (ENABLE_LOG) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, logPrint: logPrint));
    }
    //check expire time
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) async {
        handler.next(error);
      },
    ));

    return dio;
  }

  BaseOptions getDioBaseOption({String? customUrl}) {
    return BaseOptions(
      baseUrl: customUrl != null ? customUrl : instance.baseUrl,
      connectTimeout: Duration(milliseconds: TIMEOUT),
      receiveTimeout: Duration(milliseconds: TIMEOUT),
    );
  }
}
