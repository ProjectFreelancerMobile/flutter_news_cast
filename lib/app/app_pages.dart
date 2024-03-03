import 'package:get/get.dart';

import '../../ui/main/main_binding.dart';
import '../../ui/main/main_page.dart';
import '../../ui/notification/list_notification_binding.dart';
import '../../ui/notification/list_notification_page.dart';
import '../ui/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    // GetPage(
    //   name: AppRoutes.INITIAL,
    //   page: () => LoginPage(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
    ),
    // GetPage(
    //   name: AppRoutes.OTP_REGISTER,
    //   page: () => OtpPage(),
    //   binding: OtpBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.REGISTER,
    //   page: () => RegisterPage(),
    //   binding: RegisterBinding(),
    // ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.LIST_NOTIFICATION,
      page: () => ListNotificationPage(),
      binding: ListNotificationBinding(),
    ),
    /*HOME*/
    // GetPage(
    //   name: AppRoutes.ADD_DEVICE,
    //   page: () => AddDevicePage(),
    //   binding: AddDeviceBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.MANAGER_DEVICE,
    //   page: () => DevicePage(),
    //   binding: DeviceBinding(),
    //   children: [
    //     GetPage(
    //       name: AppRoutes.CHART_DETAIL,
    //       page: () => ChartDetailPage(),
    //     ),
    //   ],
    // ),
    // GetPage(
    //   name: AppRoutes.SETTING_DEVICE,
    //   page: () => DeviceSettingsPage(),
    //   binding: DeviceBinding(),
    // ),
    // /*SERVICE*/
    // GetPage(
    //   name: AppRoutes.MANAGER_LIST_DEVICE,
    //   page: () => ManagerListPage(),
    //   binding: ManagerListBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.MANAGER,
    //   page: () => ManagerPage(),
    //   binding: ManagerBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.MANAGER_SEARCH_LOCATION,
    //   page: () => ManagerSearchPage(),
    //   binding: ManagerSearchBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.MANAGER_SIZE,
    //   page: () => ManagerSizePage(),
    //   binding: ManagerBinding(),
    // ),
    // /*SETTING*/
    // GetPage(
    //   name: AppRoutes.SECURITY,
    //   page: () => SecurityPage(),
    //   binding: SecurityBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.SECURITY_EMAIL,
    //   page: () => SecurityEmailPage(),
    //   binding: SecurityBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.SECURITY_LINK,
    //   page: () => SecurityLinkPage(),
    //   binding: SecurityBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.SETTING_NOTIFICATION,
    //   page: () => SettingNotificationPage(),
    //   binding: SecurityBinding(),
    // ),
  ];
}
