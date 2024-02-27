import 'dart:developer';

import 'package:get/get.dart';

import '../../storage/my_storage.dart';
import '../models/TUser.dart';
import '../services/payment_service.dart';
import 'base_repository.dart';

class PaymentRepository extends BaseRepository {
  final _paymentService = Get.find<PaymentService>();
  final _storage = Get.find<MyStorage>();

  Future<String> paymentGetTKCT(String userName, String stk) async {
    final response = await _paymentService.paymentGetTKCT(userName, stk);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    final userNameCK = response.data["bank"]["ttk"] ?? '';
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
    }
    return userNameCK;
  }

  Future<num> paymentGetBalance(String userName) async {
    final response = await _paymentService.paymentGetBalance(userName);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
    }
    return userInfo.balance;
  }

  Future<TUser?> paymentCK(String userName, String amount, String stkChuyenTien, String bankCodeChuyenTien, String bankNameChuyenTien, String stkName, String note) async {
    final response = await _paymentService.paymentCK(userName, amount, stkChuyenTien, bankCodeChuyenTien, bankNameChuyenTien, stkName, note);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }

  Future<TUser?> paymentAddTKCT(String userName, String tkChuyenTien) async {
    final response = await _paymentService.paymentAddTKCT(userName, tkChuyenTien);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }

  Future<TUser?> paymentEditTKCT(String userName, String name, int index) async {
    final response = await _paymentService.paymentEditTKCT(userName, name, index);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }

  Future<TUser?> paymentDeleteTKCT(String userName, int index) async {
    final response = await _paymentService.paymentDeleteTKCT(userName, index);
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }

  Future<dynamic> getUserInfoPayment(String accountNumber, String bankCode) async {
    final response = await _paymentService.getUserInfoPayment(accountNumber, bankCode);
    if (response['data'] != null) {
      log('getUserInfoPayment::' + response['data']['ownerName'].toString());
      final userName = response['data']['ownerName'] ?? '';
      return userName;
    } else {
      return '';
    }
  }

  Future<TUser?> paymentAddBill(String userName, int amount, String note) async {
    var key = await _storage.getKey();
    final response = await _paymentService.paymentAddBill(userName, key, amount, note);
    log('paymentAddBill::' + response.toString());
    final user = response.data['user'];
    final userInfo = TUser.fromJson(user);
    if (userInfo.userName.isNotEmpty) {
      log('paymentAddBill1111::' + userInfo.bienDong.lastOrNull.toString());
      await _storage.saveUserInfo(userInfo);
      return userInfo;
    }
    return null;
  }
}
