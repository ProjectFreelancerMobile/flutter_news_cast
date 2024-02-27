import 'package:flutter_news_cast/data/api/api_constants.dart';

import '../models/response/api_response.dart';
import 'base_service.dart';

class PaymentService extends BaseService {
  Future<ApiResponse> paymentGetTKCT(String userName, String stk) async {
    final params = {'username': userName, 'stk': stk};
    return await post(PAYMENT_GET_TKCT, data: params);
  }

  Future<ApiResponse> paymentGetBalance(String userName) async {
    final params = {'username': userName, 'bank': 'VIETINBANK'};
    return await post(GET_BALANCER, data: params);
  }

  Future<ApiResponse> paymentCK(String userName, String amount, String stkChuyenTien, String bankCodeChuyenTien, String bankNameChuyenTien, String stkName, String note) async {
    final params = {
      'username': userName,
      'amount': amount,
      "stkChuyenTien": stkChuyenTien,
      "bankCodeChuyenTien": bankCodeChuyenTien,
      "bankNameChuyenTien": bankNameChuyenTien,
      "bank": "VIETINBANK",
      "bankName": "VIETINBANK",
      "ndNhanTien": note,
      "stkName": stkName
    };
    return await post(PAYMENT_CK, data: params);
  }

  Future<ApiResponse> paymentAddTKCT(String userName, String tkChuyenTien) async {
    final params = {'username': userName, 'tkChuyenTien': tkChuyenTien};
    return await post(PAYMENT_ADD_TKCT, data: params);
  }

  Future<ApiResponse> paymentEditTKCT(String userName, String name, int index) async {
    final params = {'username': userName, 'name': name, 'index': index};
    return await post(PAYMENT_EDIT_TKCT, data: params);
  }

  Future<ApiResponse> paymentDeleteTKCT(String userName, int index) async {
    final params = {'username': userName, 'index': index};
    return await post(PAYMENT_DELETE_TKCT, data: params);
  }

  Future<ApiResponse> paymentAddBill(String userName, String key, int amount, String note) async {
    final params = {'username': userName, 'password': key, 'amount': amount, 'ndNhanTien': note, 'role': '16715028', 'bank': 'VIETINBANK', 'bankName': 'VIETINBANK'};
    return await post(PAYMENT_ADD_BILL, data: params);
  }

  Future<dynamic> getUserInfoPayment(String accountNumber, String bankCode) async {
    final params = {'bankCode': bankCode, 'accountNumber': accountNumber};
    return await postString(PAYMENT_STK, data: params);
  }
}
