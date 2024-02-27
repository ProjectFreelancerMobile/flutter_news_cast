/*
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../app/my_app.dart';
import '../data/api/models/notification_item.dart';
import '../utils/local_notification_manager.dart';
import 'app_controller.dart';

class PushNotificationManager with HandleNotificationMixin {
  LocalNotificationManager? localNotificationManager;

  init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    localNotificationManager = LocalNotificationManager();
    onReceiverMessage();
    await localNotificationManager?.init();
  }

  void onReceiverMessage() async {
    FirebaseMessaging.instance.subscribeToTopic("Telemed");
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await Get.find<AppController>().updateFirebaseToken(token: token);
      print("Firebase onTokenRefresh token: $token");
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        var data = getNotificationData(message.data['ejson']);
        print("Firebase message: $data");
        if (data != null) {
          Future.delayed(const Duration(seconds: 1), () {
            handleNotification(data);
          });
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        var notification = _getNotification(message);
        var data = getNotificationData(message.data['ejson']);
        print("Firebase onMessage: $data");
        if (notification != null && notification.android != null)
          await localNotificationManager?.showNotification(
              notification.title, notification.body,
              payload: message.data['ejson'] ?? "");
      } catch (e) {
        print(e);
      }
    });
    //Truong hop app chay background nhung chua tat han
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var data = getNotificationData(message.data['ejson']);
      print("Firebase data: $data");
      if (data != null) {
        Future.delayed(const Duration(seconds: 1), () {
          handleNotification(data);
        });
      }
    });

    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await Get.find<AppController>().updateFirebaseToken(token: token);
      print("Firebase token: $token");
    }
  }

  RemoteNotification? _getNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    return notification ?? null;
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

NotificationItem? getNotificationData(String ejson) {
  try {
    NotificationItem data;
    data = NotificationItem.fromJson(json.decode(ejson));
    return data;
  } catch (error) {
    print("LOMO_JSON_ERROR: $error ");
    return null;
  }
}
*/
