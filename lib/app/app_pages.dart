import 'package:get/get.dart';

import '../../ui/notification/list_notification_binding.dart';
import '../../ui/notification/list_notification_page.dart';
import '../ui/add_user/add_bill_page.dart';
import '../ui/add_user/add_user_binding.dart';
import '../ui/add_user/add_user_page.dart';
import '../ui/auth/login_binding.dart';
import '../ui/auth/login_page.dart';
import '../ui/main/main_binding.dart';
import '../ui/main/main_page.dart';
import '../ui/main/tk/balance_info_page.dart';
import '../ui/main/tk/bank_detail_page.dart';
import '../ui/payment/payment_binding.dart';
import '../ui/payment/payment_detail_page.dart';
import '../ui/payment/payment_info_page.dart';
import '../ui/payment/payment_page.dart';
import '../ui/payment/payment_success_page.dart';
import '../ui/payment/payment_welcome_page.dart';
import '../ui/qrcode/qrcode_binding.dart';
import '../ui/qrcode/qrcode_page.dart';
import '../ui/settings/setting_binding.dart';
import '../ui/settings/settings_page.dart';
import '../ui/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => LoginUserPage(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: AppRoutes.LOGIN_TK,
          page: () => LoginUserPage(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: AppRoutes.BALANCE,
          page: () => BalanceInfoPage(),
        ),
        GetPage(
          name: AppRoutes.BANK_DETAIL,
          page: () => BankDetailPage(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.QRCODE,
      page: () => QRCodePage(),
      binding: QRCodeBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_USER,
      page: () => AddUserPage(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_BILL,
      page: () => AddBillPage(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: AppRoutes.LIST_NOTIFICATION,
      page: () => ListNotificationPage(),
      binding: ListNotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => SettingsPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.PAYMENT_WELCOME,
      page: () => PaymentWelcomePage(),
      binding: PaymentBinding(),
      children: [
        GetPage(
          name: AppRoutes.PAYMENT,
          page: () => PaymentPage(),
        ),
        GetPage(
          name: AppRoutes.PAYMENT_INFO,
          page: () => PaymentInfoPage(),
        ),
        GetPage(
          name: AppRoutes.PAYMENT_DETAIL,
          page: () => PaymentDetailPage(),
        ),
        GetPage(
          name: AppRoutes.PAYMENT_SUCCESS,
          page: () => PaymentSuccessPage(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.PAYMENT_INFO,
      page: () => PaymentInfoPage(),
      binding: PaymentBinding(),
    ),
  ];
}
