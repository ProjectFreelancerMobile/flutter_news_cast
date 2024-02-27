import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/data/api/models/payment/payment_item.dart';
import 'package:flutter_news_cast/data/api/repositories/payment_repository.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/ui/base/base_controller.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';

import '../../app/app_controller.dart';
import '../../app/app_pages.dart';
import '../../data/api/models/TUser.dart';
import '../../data/api/models/bank/List_Bank_entity.dart';
import '../../res/gen/assets.gen.dart';
import '../../utils/data_util.dart';
import '../../utils/debouncer.dart';

class PaymentController extends BaseController {
  final _paymentRepository = Get.find<PaymentRepository>();
  final _appController = Get.find<AppController>();
  TextEditingController textStkCl = TextEditingController();
  TextEditingController textBankCl = TextEditingController();
  TextEditingController textPriceCl = TextEditingController();
  TextEditingController textNoteCl = TextEditingController();

  //User
  var _user = TUser().obs;

  TUser get user => _user.value;

  final stepType = PAYMENT_TYPE.NONE.obs;
  //Check
  FocusNode? myFocusNodeStk;
  RxBool hasEditStk = false.obs;
  RxBool hasEditBank = false.obs;
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  List<BankDetail> get listBank => _listBank$.value;
  final _listBank$ = <BankDetail>[].obs;

  List<BankDetail> get listBankSearch => _listBankSearch$.value;
  final _listBankSearch$ = <BankDetail>[].obs;

  BankDetail get bankDetail => _bankDetail$.value;
  final _bankDetail$ = BankDetail().obs;

  //Info
  FocusNode? myFocusNodePrice;
  FocusNode? myFocusNodeNote;
  RxBool hasEditPrice = false.obs;
  RxBool hasEditNote = false.obs;
  var isShowQRCode = false;

  String get nameTKCKInfo => _nameTKCKInfo.value;
  var _nameTKCKInfo = ''.obs;
  RxBool switchSaveContact = false.obs;

  //Detail
  ValueNotifier timerNotifier = ValueNotifier(null);
  TextEditingController textOtpController = TextEditingController();
  RxBool hasError = false.obs;
  String currentText = "";
  RxString moneyText = ''.obs;
  RxString nameSTKText = ''.obs;
  var onEditSearchName = true;
  var isUserInput = true;

  PaymentItem get paymentItem => _appController.paymentItem;

  ImageProvider<Object> themeMain() => _appController.themeMain();

  @override
  void onInit() async {
    super.onInit();
    initFirst();
    print('isShowQRCode:::' + isShowQRCode.toString());
    if (isShowQRCode) {
      initQRCode();
    }
  }

  bool get isNone => stepType == PAYMENT_TYPE.NONE;

  bool get isShowButtonInfo => stepType == PAYMENT_TYPE.INFO;

  void initFirst() {
    isShowQRCode = false;
    stepType.value = PAYMENT_TYPE.NONE;
    myFocusNodeStk = FocusNode();
    myFocusNodePrice = FocusNode();
    myFocusNodeNote = FocusNode();
    _user.value = _appController.user ?? TUser();
    nameSTKText.value = paymentItem.userNameFromSTK ?? '';
    print('paymentItem::' + _appController.paymentItem.toString());
    isShowQRCode = Get.arguments ?? false;
  }

  void initQRCode() async {
    print('showPaymentFromQRCode::' + (_appController.paymentItem).toString());
    textPriceCl.text = formatCurrencyRaw(paymentItem.amount);
    textNoteCl.text = paymentItem.noteNull?.isNotEmpty == true ? (paymentItem.noteNull ?? '') : '${user.displayName} chuyen tien';
    _appController.paymentItem.updatePayment(amount: int.tryParse(textPriceCl.text.replaceAll(',', '')), note: textNoteCl.text);
    stepType == PAYMENT_TYPE.NONE;
    nameSTKText.value = await paymentGetTKCTBank((error) {}, stkNeed: paymentItem.stk, binBank: paymentItem.bankDetail?.bin);
  }

  @override
  void dispose() {
    myFocusNodeStk?.dispose();
    myFocusNodePrice?.dispose();
    myFocusNodeNote?.dispose();
    textStkCl.dispose();
    textBankCl.dispose();
    textPriceCl.dispose();
    textNoteCl.dispose();
    super.dispose();
  }

  //Payment Info
  Future<void> loadJsonAssetListBank() async {
    textBankCl.clear();
    _nameTKCKInfo.value = '';
    _bankDetail$.value = BankDetail();
    onEditSearchName = true;
    final String jsonString = await rootBundle.loadString(Assets.json.listBankIcon);
    final data = jsonDecode(jsonString);
    _listBank$.value = List_Bank.fromJson(data).data ?? List.empty();
    _listBankSearch$.value = _listBank$.value;
    print('listBank::' + listBank.toString());
  }

  onCheckEdit({bool isName = false, bool isClear = false}) {
    if (isName) {
      hasEditStk.value = textStkCl.text.isNotEmpty;
      if (textStkCl.text.length > 3 && hasEditBank.value) {
        stepType.value = PAYMENT_TYPE.INFO;
      }
    }
    if (isClear) {
      textStkCl.clear();
      hasEditStk.value = textStkCl.text.isNotEmpty;
    }
  }

  onSearchBank(String? text) {
    if (text == null) return;
    _debouncer.call(() {
      _listBankSearch$.value = listBank.where((element) => element.shortName?.toLowerCase().contains(text.toLowerCase()) == true).toList();
    });
  }

  onPickBank(BankDetail bankDetail) {
    _bankDetail$.value = bankDetail;
    textBankCl.text = bankDetail.name ?? '';
    _appController.paymentItem.updatePayment(bankDetail: bankDetail);
    hasEditBank.value = textBankCl.text.isNotEmpty;
    Get.back();
    if (hasEditStk.value) {
      stepType.value = PAYMENT_TYPE.INFO;
    } else {
      myFocusNodeStk?.requestFocus();
    }
  }

  //Payment detail
  onUpdateMoney(String? value) {
    moneyText.value = formatMoney(value ?? '');
    hasEditPrice.value = textPriceCl.text.isNotEmpty;
    if (hasEditPrice.value) {
      stepType.value = PAYMENT_TYPE.DETAIL;
    }
  }

  onUpdatePaymentStep(PAYMENT_TYPE payment_type) {
    if (payment_type == PAYMENT_TYPE.INFO) {
      textNoteCl.text = '${user.displayName} chuyen tien';
      hasEditNote.value = textNoteCl.text.isNotEmpty;
      myFocusNodePrice?.requestFocus();
    }
  }

  onUpdatePaymentPriceType(bool isQrCode) {
    if (myFocusNodePrice?.hasFocus == true) {
      print('onUpdatePaymentPriceType:myFocusNodePrice' + (myFocusNodePrice?.hasFocus).toString() + "myFocusNodeNote:" + (myFocusNodeNote?.hasFocus).toString());
      if (textPriceCl.text.isEmpty) return;
      if (!isQrCode) {
        stepType.value = PAYMENT_TYPE.DETAIL;
        if (textNoteCl.text.isEmpty) {
          stepType.value = PAYMENT_TYPE.DETAIL;
          textNoteCl.text = '${user.displayName} chuyen tien';
          myFocusNodeNote?.requestFocus();
        } else {
          stepType.value = PAYMENT_TYPE.DETAIL;
        }
      }
    }
  }

  onUpdatePaymentNoteType() {
    if (myFocusNodeNote?.hasFocus == true) {
      print('onUpdatePaymentNoteType:myFocusNodePrice' + (myFocusNodePrice?.hasFocus).toString() + "myFocusNodeNote:" + (myFocusNodeNote?.hasFocus).toString());
      if (textNoteCl.text.isEmpty) return;
      stepType.value = PAYMENT_TYPE.DETAIL;
    }
  }

  navPaymentDetailsCK(Function(String) errorMessage) async {
    try {
      print('navPaymentDetailsCK::' + paymentItem.toString());
      if (paymentItem.bankDetail != null && paymentItem.amount != 0) {
        final isSuccess = await paymentCK(
          paymentItem.bankDetail?.code ?? '',
          paymentItem.bankDetail?.shortName ?? '',
          paymentItem.amount.toString(),
          paymentItem.stk,
          paymentItem.userNameBank ?? '',
          paymentItem.note,
          errorMessage,
        );
        if (isSuccess) {
          Get.toNamed(AppRoutes.NAV_PAYMENT_SUCCESS);
        }
      } else {
        errorMessage('Vui lòng nhập số tiền trước khi chuyển!');
      }
    } catch (e) {
      print(e);
      errorMessage(e.toString());
    }
  }

  Future<bool> paymentCK(String bankCode, String bankName, String price, String stk, String stkName, String note, Function(String) errorMessage) async {
    try {
      final userInfo = await _paymentRepository.paymentCK(user.userName, price, stk, bankCode, bankName, stkName, note);
      print('paymentCK::success' + userInfo.toString());
      if (userInfo != null) {
        _user.value = userInfo;
        await Get.find<AppController>().initAuth();
        final homeController = await Get.find<HomeController>();
        homeController.updateBienDong(user);
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      print('paymentCK::' + e.toString());
      errorMessage(getErrors(e));
      return Future.value(false);
    }
  }

  Future<num> paymentGetBalance(Function(String) errorMessage) async {
    try {
      final balance = await _paymentRepository.paymentGetBalance(user.userName);
      print('paymentGetBalance::success');
      return Future.value(balance);
    } catch (e) {
      print('paymentGetBalance::' + e.toString());
      errorMessage(getErrors(e));
      return Future.value(0);
    }
  }

  String generateBillCode() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  String generateOTP() {
    var rng = Random();
    var code = rng.nextInt(999999) + 11111111;
    return code.toString().replaceAll('', ' ');
  }

  onSaveContact(bool value) {
    switchSaveContact.value = value;
  }

  navPaymentDetails(Function(String) errorMessage) async {
    print('navPaymentDetails:' + nameTKCKInfo);
    //showLoading();
    if (nameTKCKInfo.isEmpty) {
      _nameTKCKInfo.value = await paymentGetTKCTBank(errorMessage);
    }
    if (textStkCl.text.isEmpty) {
      errorMessage('Vui lòng không để trống số tài khoản');
      return;
    }
    if (bankDetail.code == null) {
      errorMessage('Vui lòng chọn ngân hàng!');
      return;
    }
    Get.toNamed(AppRoutes.NAV_PAYMENT_INFO);
  }

  Future<String> paymentGetTKCTBank(Function(String) errorMessage, {String? stkNeed, String? binBank}) async {
    var userNameFromSTK = '';
    try {
      print('bankDetail:' + (bankDetail.bin ?? '').toString() + "stk::" + textStkCl.text);
      if (stkNeed != null && binBank != null) {
        isUserInput = false;
        userNameFromSTK = await _paymentRepository.getUserInfoPayment(stkNeed, binBank);
        if (userNameFromSTK.isEmpty) {
          isUserInput = true;
          userNameFromSTK = await paymentGetTKCT(errorMessage);
        }
      } else if (bankDetail.bin != null && textStkCl.text.isNotEmpty) {
        isUserInput = false;
        userNameFromSTK = await _paymentRepository.getUserInfoPayment(textStkCl.text, bankDetail.bin ?? '');
        if (userNameFromSTK.isEmpty) {
          isUserInput = true;
          userNameFromSTK = await paymentGetTKCT(errorMessage);
        }
      } else {
        userNameFromSTK = await paymentGetTKCT(errorMessage);
      }
    } catch (e) {
      userNameFromSTK = await paymentGetTKCT(errorMessage);
    }
    print('paymentGetTKCTBank::' + e.toString());
    if (textStkCl.text.isNotEmpty) {
      _appController.paymentItem.updatePayment(stk: textStkCl.text, userNameBank: isUserInput ? '' : userNameFromSTK, userNameInput: isUserInput ? userNameFromSTK : '');
    } else {
      _appController.paymentItem.updatePayment(userNameBank: isUserInput ? '' : userNameFromSTK, userNameInput: isUserInput ? userNameFromSTK : '');
    }
    return Future.value(userNameFromSTK);
  }

  Future<String> paymentGetTKCT(Function(String) errorMessage) async {
    try {
      isUserInput = true;
      final userNameCK = await _paymentRepository.paymentGetTKCT(user.userName, textStkCl.text);
      print('paymentGetTKCT::success');
      return Future.value(userNameCK);
    } catch (e) {
      print('paymentGetTKCT::' + e.toString());
      errorMessage(getErrors(e));
      return Future.value('');
    }
  }

  navPaymentDetailsInfo(Function(String) errorMessage) {
    if (textPriceCl.text.isEmpty) {
      errorMessage('Vui lòng không để trống số tiền');
      return;
    }
    try {
      if (textPriceCl.text.isNotEmpty) {
        print('textPriceCl.text::' + textPriceCl.text);
        _appController.paymentItem.updatePayment(note: textNoteCl.text, amount: int.tryParse(textPriceCl.text.replaceAll(',', '')), numberBill: generateBillCode(), money: moneyText.value);
        Get.toNamed(AppRoutes.NAV_PAYMENT_DETAIL);
      }
    } catch (e) {
      print(e);
      errorMessage(e.toString());
    }
  }

  void resetPayment() {
    _appController.resetPayment();
  }
}
