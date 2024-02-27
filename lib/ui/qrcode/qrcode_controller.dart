import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/ui/base/base_controller.dart';

import '../../app/app_controller.dart';
import '../../data/api/models/bank/List_Bank_entity.dart';
import '../../data/api/models/payment/payment_item.dart';
import '../../res/gen/assets.gen.dart';
import '../widgets/qrcode/ai_barcode_scanner.dart';

class QRCodeController extends BaseController {
  final _appController = Get.find<AppController>();

  //QRCode
  MobileScannerController? cameraController = null;
  bool isScan = true;

  @override
  void onInit() async {
    super.onInit();
  }

  void scanQRCodeTest(Function(PaymentItem) callBack) async {
    final qrCodeTestVietQrNote = '00020101021138580010A000000727012800069704070114190720548670110208QRIBFTTA53037045802VN62090805Hello63040D62';
    final qrCodeTestVietQrNoteMoney = '00020101021238580010A000000727012800069704070114190720548670110208QRIBFTTA5303704540710000005802VN62080804Test630418A8';
    final qrCodeTestTechcombankNoteMoney = '00020101021238580010A000000727012800069704070114190720548670110208QRIBFTTA5303704540410005802VN62080804test83008400630464C9';
    final qrCodeTest = '00020101021138580010A000000727012800069704070114190720548670110208QRIBFTTA53037045802VN830084006304ECA3';
    final qrCodeTestVPBank = '00020101021138540010A00000072701240006970432011003333320930208QRIBFTTA53037045802VN630448E1';
    final qrCodeTestVPBankNoteMoney = '00020101021238540010A00000072701240006970432011003333320930208QRIBFTTA5303704540420005802VN63047AF6';
    var count = qrCodeTest.contains('VN620') ? int.tryParse(qrCodeTest.substring(qrCodeTest.indexOf('VN620') + 8, qrCodeTest.indexOf('VN620') + 10)) : 0;
    var binBank = qrCodeTest.contains('0006') ? qrCodeTest.substring(qrCodeTest.indexOf('0006') + 4, qrCodeTest.indexOf('0006') + 10) : '';
    var bankDetail = await onSearchBankFromBin(binBank);
    var paymentItemTest = PaymentItem(
      amount: qrCodeTest.contains('QRIBFTTA530370454')
          ? int.tryParse(qrCodeTest.substring(qrCodeTest.indexOf('QRIBFTTA530370454') + 19, qrCodeTestVietQrNoteMoney.indexOf('5802VN')))
          : 0,
      stk: qrCodeTest.contains('69704') ? qrCodeTest.substring(qrCodeTest.indexOf('69704') + 11, qrCodeTest.indexOf('0208QRIBFTT')) : '',
      note: qrCodeTest.contains('VN620') ? qrCodeTest.substring(qrCodeTest.indexOf('VN620') + 10, qrCodeTest.indexOf('VN620') + 10 + (count ?? 0)) : '',
      bankDetail: bankDetail,
    );
    print('paymentItemVietQRNote::' + paymentItemTest.toString());
    _appController.paymentItem.updatePayment(
      stk: paymentItemTest.stk,
      amount: paymentItemTest.amount,
      note: paymentItemTest.note,
      bankDetail: paymentItemTest.bankDetail,
    );
    callBack(paymentItemTest);
    disposeScanQR();
  }

  void scanDecodeQRCode(String rawValue, Function(PaymentItem) callBack) async {
    if (!isScan) return;
    isScan = false;
    var count = rawValue.contains('VN620') ? int.tryParse(rawValue.substring(rawValue.indexOf('VN620') + 8, rawValue.indexOf('VN620') + 10)) : 0;
    final binBank = rawValue.contains('0006') ? rawValue.substring(rawValue.indexOf('0006') + 4, rawValue.indexOf('0006') + 10) : '';
    var bankDetail = await onSearchBankFromBin(binBank);
    var paymentScanItem = PaymentItem(
      amount: rawValue.contains('QRIBFTTA530370454') ? int.tryParse(rawValue.substring(rawValue.indexOf('QRIBFTTA530370454') + 19, rawValue.indexOf('5802VN'))) : 0,
      stk: rawValue.contains('69704') ? rawValue.substring(rawValue.indexOf('69704') + 11, rawValue.indexOf('0208QRIBFTT')) : '',
      note: rawValue.contains('VN620') ? rawValue.substring(rawValue.indexOf('VN620') + 10, rawValue.indexOf('VN620') + 10 + (count ?? 0)) : '',
      bankDetail: bankDetail,
    );
    _appController.paymentItem.updatePayment(
      stk: paymentScanItem.stk,
      amount: paymentScanItem.amount,
      note: paymentScanItem.note,
      bankDetail: paymentScanItem.bankDetail,
    );
    callBack(paymentScanItem);
    disposeScanQR();
  }

  void startScanQR() {
    isScan = true;
    cameraController = MobileScannerController(formats: [BarcodeFormat.qrCode]);
  }

  void disposeScanQR() {
    cameraController?.dispose();
  }

  Future<BankDetail?> onSearchBankFromBin(String? text) async {
    if (text == null) return null;
    final String jsonString = await rootBundle.loadString(Assets.json.listBankIcon);
    final data = jsonDecode(jsonString);
    final listBank = List_Bank.fromJson(data).data ?? List.empty();
    var bank = listBank.firstWhereOrNull((element) => element.bin == text);
    print('onSearchBankFromBin::' + bank.toString());
    return Future.value(bank);
  }

  @override
  void dispose() {
    disposeScanQR();
    super.dispose();
  }
}
