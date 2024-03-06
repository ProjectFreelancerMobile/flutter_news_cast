import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_news_cast/data/api/api_constants.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../storage/key_constant.dart';
import '../models/response/api_response.dart';
import '../rest_client.dart';

abstract class BaseService {
  Future<dynamic> getWithUrlRss(String customUrl) async {
    final response = await RestClient.getDio(customUrl: customUrl).get('');
    return response.data;
  }

  Future<dynamic> getWithCustomUrl(String customUrl, String path, {Map<String, dynamic>? params}) async {
    final response = await RestClient.getDio(customUrl: customUrl).get(path, queryParameters: params);
    return response.data;
  }

  Future<dynamic> getWithCustomUrlPost(String customUrl, String path, {Map<String, dynamic>? data}) async {
    final response = await RestClient.getDio(customUrl: customUrl).post(path, data: data);
    return response.data;
  }

  Future<ApiResponse> get(String path, {Map<String, dynamic>? params}) async {
    if (isConnection) {
      final response = await RestClient.getDio().get(path, queryParameters: params);
      return _handleResponse(response);
    } else {
      return _handleResponseLostConnect();
    }
  }

  Future<ApiResponse> post(String path, {data, bool enableCache = false}) async {
    if (isConnection) {
      final response = await RestClient.getDio().post(path, data: data);
      return _handleResponse(response);
    } else {
      return _handleResponseLostConnect();
    }
  }

  Future<ApiResponse> put(String path, {data}) async {
    final response = await RestClient.getDio().put(path, data: data);
    return _handleResponse(response);
  }

  Future<ApiResponse> delete(String path, {data}) async {
    final response = await RestClient.getDio().delete(path, data: data);
    return _handleResponse(response);
  }

  Future<ApiResponse> postUpload(String path, {data}) async {
    final response = await RestClient.getDio().post(path, data: data);
    return _handleResponse(response);
  }

  ApiResponse _handleResponse(dio.Response response) {
    Map result = jsonDecode(response.data);
    if (result['status'] == STATUS_TYPE.OK.name) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(response.data));
      print('_handleResponse:ok::' + apiResponse.toString());
      return apiResponse;
    } else {
      var apiResponse = ApiResponse.fromJson(jsonDecode(response.data));
      print('_handleResponse:fail::' + apiResponse.toString());
      return throw apiResponse;
    }
  }

  ApiResponse _handleResponseLostConnect() {
    print("_handleResponseLostConnect::");
    return throw ApiResponse(
      code: 0,
      message: textLocalization('setting.error.connect'),
    );
  }
}
