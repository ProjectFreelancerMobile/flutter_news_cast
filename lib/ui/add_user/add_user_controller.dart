import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';

import '../../../data/storage/my_storage.dart';
import '../../app/app_controller.dart';
import '../../data/api/models/TUser.dart';
import '../../data/api/repositories/payment_repository.dart';
import '../../utils/data_util.dart';
import '../base/base_controller.dart';

class AddUserController extends BaseController {
  final _paymentRepository = Get.find<PaymentRepository>();
  final storage = Get.find<MyStorage>();
  final txtNameController = TextEditingController();
  final txtNameEditController = TextEditingController();
  TextEditingController textPriceCl = TextEditingController();
  TextEditingController textNoteCl = TextEditingController();

  List<dynamic> get listUser => _listUser$.value;
  final _listUser$ = <dynamic>[].obs;
  RxInt lenghtIndex = 0.obs;
  RxString moneyText = ''.obs;
  var _user = TUser().obs;

  TUser get user => _user.value;

  @override
  void onInit() async {
    super.onInit();
    //await storage.box.remove('app_list_user');
    _listUser$.value = Get.find<AppController>().user?.taiKhoanChuyenTien ?? [];
    lenghtIndex.value++;
  }

  void addUser() {
    if (txtNameController.text.isNotEmpty) {
      var newList = listUser;
      newList.add(txtNameController.text);
      _listUser$.value = newList;
      print('addUser' + listUser.toString());
      txtNameController.clear();
      lenghtIndex.value++;
    }
  }

  void updateUser(int index, String nameUpdate) {
    if (listUser.length >= index) {
      _listUser$[index] = nameUpdate;
      print('addUser' + listUser.toString());
      lenghtIndex.value++;
    }
  }

  void removeUser(int index) {
    if (listUser.length >= index) {
      _listUser$.value.removeAt(index);
      print('addUser' + listUser.toString());
      lenghtIndex.value++;
    }
  }

  onUpdateMoney(String? value) {
    moneyText.value = formatMoney(value ?? '');
  }

  onUpdateEditUser(String? value) {
    txtNameEditController.text = value ?? '';
  }

  paymentAddTKCT(Function(bool, String) errorMessage) async {
    try {
      var userName = Get.find<AppController>().user?.userName ?? '';
      if (userName.isNotEmpty) {
        final userInfo = await _paymentRepository.paymentAddTKCT(userName, txtNameController.text);
        print('paymentAddTKCT::success');
        if (userInfo != null) {
          await Get.find<AppController>().initAuth();
          errorMessage(false, 'Thêm tài khoản thành công.');
          addUser();
        } else {
          errorMessage(true, 'Thêm tài khoản thất bại.');
        }
      } else {
        errorMessage(true, 'Tên tài khoản không tìm thấy!');
      }
    } catch (e) {
      print('paymentAddTKCT::' + e.toString());
      errorMessage(true, getErrors(e));
    }
  }

  paymentEditTKCT(int index, Function(bool, String) errorMessage) async {
    try {
      var userName = Get.find<AppController>().user?.userName ?? '';
      if (userName.isNotEmpty) {
        final userInfo = await _paymentRepository.paymentEditTKCT(userName, txtNameEditController.text, index);
        print('paymentEditTKCT::success');
        if (userInfo != null) {
          await Get.find<AppController>().initAuth();
          errorMessage(false, 'Sửa tài khoản thành công.');
          updateUser(index, txtNameEditController.text);
        } else {
          errorMessage(true, 'Sửa tài khoản thất bại.');
        }
      } else {
        errorMessage(true, 'Tên tài khoản không tìm thấy!');
      }
    } catch (e) {
      print('paymentEditTKCT::' + e.toString());
      errorMessage(true, getErrors(e));
    }
  }

  paymentDeleteTKCT(int index, Function(bool, String) errorMessage) async {
    try {
      var userName = Get.find<AppController>().user?.userName ?? '';
      if (userName.isNotEmpty) {
        final userInfo = await _paymentRepository.paymentDeleteTKCT(userName, index);
        print('paymentDeleteTKCT::success');
        if (userInfo != null) {
          await Get.find<AppController>().initAuth();
          errorMessage(false, 'Xoá tài khoản thành công.');
          removeUser(index);
        } else {
          errorMessage(true, 'Xoá tài khoản thất bại.');
        }
      } else {
        errorMessage(true, 'Tên tài khoản không tìm thấy!');
      }
    } catch (e) {
      print('paymentDeleteTKCT::' + e.toString());
      errorMessage(true, getErrors(e));
    }
  }

  paymentAddBill(Function(bool, String) errorMessage) async {
    try {
      var userName = Get.find<AppController>().user?.userName ?? '';
      if (userName.isNotEmpty) {
        final userInfo = await _paymentRepository.paymentAddBill(userName, int.tryParse(textPriceCl.text.replaceAll(',', '')) ?? 0, textNoteCl.text);
        print('paymentAddTKCT::success');
        if (userInfo != null) {
          _user.value = userInfo;
          await Get.find<AppController>().initAuth();
          final homeController = await Get.find<HomeController>();
          homeController.updateBienDong(user);
          errorMessage(false, 'Thêm tiền thành công.');
        } else {
          errorMessage(true, 'Thêm tiền thất bại.');
        }
      } else {
        errorMessage(true, 'Tên tài khoản không tìm thấy!');
      }
    } catch (e) {
      print('paymentAddTKCT::' + e.toString());
      errorMessage(true, getErrors(e));
    }
  }

  @override
  void dispose() {
    txtNameController.dispose();
    txtNameEditController.dispose();
    textPriceCl.dispose();
    textNoteCl.dispose();
    super.dispose();
  }
}
