part of 'app_pages.dart';

abstract class AppRoutes {
  static const INITIAL = '/home';

  //LOGIN
  static const LOGIN_TK = '/login_tk';

  static const NAV_LOGIN_USER = INITIAL + LOGIN_TK;

  static const MAIN = '/main';
  static const SPLASH = '/splash';
  static const ADD_USER = '/add_user';
  static const ADD_BILL = '/add_bill';
  static const LIST_NOTIFICATION = '/list_notification';
  static const BALANCE = '/balance';
  static const BANK_DETAIL = '/bank_detail';
  static const QRCODE = '/qrcode';
  static const PAYMENT_WELCOME = '/payment_welcome';
  static const PAYMENT = '/payment';
  static const PAYMENT_INFO = '/payment_info';
  static const PAYMENT_DETAIL = '/payment_detail';
  static const PAYMENT_SUCCESS = '/payment_success';

  static const SETTING = '/setting';

  static const NAV_BALANCE_INFO = MAIN + BALANCE;
  static const NAV_BANK_INFO = MAIN + BANK_DETAIL;
  static const NAV_PAYMENT = PAYMENT_WELCOME + PAYMENT;
  static const NAV_PAYMENT_INFO = PAYMENT_WELCOME + PAYMENT_INFO;
  static const NAV_PAYMENT_DETAIL = PAYMENT_WELCOME + PAYMENT_DETAIL;
  static const NAV_PAYMENT_SUCCESS = PAYMENT_WELCOME + PAYMENT_SUCCESS;
}
