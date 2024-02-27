import 'dart:async';

import '../api_constants.dart';
import '../models/response/api_response.dart';
import 'base_service.dart';

class UserService extends BaseService {
  Future<ApiResponse> loginByEmail(String userName, String password, String deviceID) async {
    final params = {'username': userName, 'password': password, 'deviceID': deviceID, 'bank': 'VIETINBANK'};
    return await post(LOGIN_BY_EMAIL, data: params);
  }
}
