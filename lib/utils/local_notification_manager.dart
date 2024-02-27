/*
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../app/push_notification_manager.dart';
import '../app/my_app.dart';

class LocalNotificationManager with HandleNotificationMixin {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  init() async {
    _requestPermissions();
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        var data = getNotificationData(payload);
        if (data != null) {
          Future.delayed(const Duration(seconds: 1), () {
            handleNotification(data);
          });
        }
      }
    });
    //Khi co push local,sau do tat app va bam vao noti tren thanh bar
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String? payload = notificationAppLaunchDetails!.payload;
      if (payload != null) {
        var data = getNotificationData(payload);
        if (data != null) {
          Future.delayed(const Duration(seconds: 2), () {
            handleNotification(data);
          });
        }
      }
    }
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  int fcmId = 0;

  Future<void> showNotification(String? title, String? body,
      {String? payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("notification_travel", 'Travel',
            importance: Importance.max,
            playSound: true,
            priority: Priority.high,
            autoCancel: true,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        fcmId++, title ?? null, body ?? null, platformChannelSpecifics,
        payload: payload ?? null);
  }
}
*/

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter_news_cast/data/api/models/TUser.dart';

import '../data/api/api_constants.dart';
import 'data_util.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
int id = 0;
bool isShowNotification = false;

Future<void> showNotification(String bienDong, TUser user) async {
  if (isShowNotification) return;
  isShowNotification = true;
  final isAddMoney = getDataType(bienDong);
  final getMoney = formatCurrencyRaw(int.tryParse(getDataMoney(bienDong)) ?? 0);
  final getNote = getDataNote(bienDong);
  final getSTK = user.soTaiKhoan;
  final dateTime = DateFormat(DATE_TIME_FORMAT2).format(DateTime.now());
  var getTotalMoney = formatCurrencyRaw(int.tryParse(getDataSoDu(bienDong)) ?? 0);
  if (getTotalMoney == '0') {
    getTotalMoney = user.getTotalMoney;
  }
  var data = 'VietinBank:${dateTime}|\nTK:$getSTK|GD:${isAddMoney ? '+' : '-'}${getMoney}VND|\nSDC:${getTotalMoney}VND|ND:$getNote';
  print('data::' + data.toString());
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    data,
    htmlFormatBigText: true,
    contentTitle: 'VietinBank',
    htmlFormatContentTitle: true,
  );
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'com.app.vietinbank',
    'VietinBank',
    channelDescription: 'VietinBank',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
    ticker: 'ticker',
    visibility: NotificationVisibility.public,
    styleInformation: bigTextStyleInformation,
  );
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );
  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {},
  );
  //showToastNotification(isAddMoney, getSTK, getTotalMoney, getMoney, getNote);
  await flutterLocalNotificationsPlugin.show(
    id++,
    'VietinBank',
    data,
    notificationDetails,
    payload: 'data',
  );
  Future.delayed(Duration(seconds: 1), () {
    isShowNotification = false;
  });
}

void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}
