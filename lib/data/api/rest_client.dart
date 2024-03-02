// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

import '../../utils/log_data.dart';

class RestClient {
  static const TIMEOUT = 30000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';
  static const LANGUAGE = 'Accept-Language';

  // singleton
  static final RestClient instance = new RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  late String baseUrl;
  late Map<String, dynamic> headers;

  void init(String baseUrl, {String? accessToken}) {
    this.baseUrl = baseUrl;
    headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    if (accessToken != null && accessToken.isNotEmpty) setToken(accessToken);
    //setLanguage(language!);
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = "Bearer $token";
  }

  void setLanguage(String language) {
    headers[LANGUAGE] = language;
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
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
      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }
}
