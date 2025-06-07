import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void onTap(NotificationResponse notificationResponse) {
    log("Notification Tapped: ${notificationResponse.payload}");
    // You can use navigatorKey.currentContext to navigate from anywhere
  }

  static Future<void> initNitification() async {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel', // must match channel id in the notification details
      'Default Notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // show basic notification
  // static void showBasicNotification() async {
  //   NotificationDetails notificationDetails = const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'id 1',
  //       'Basic Notifications',
  //       channelDescription: 'Channel for showing basic notifications',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       playSound: true,
  //       ticker: 'ticker',
  //     ),
  //   );

  //   int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(10000);
  //   await flutterLocalNotificationsPlugin.show(
  //     notificationId,
  //     ' جدا طلب جديد',
  //     'تم استلام طلب جديد من المستخدم طلب جديد',
  //     notificationDetails,
  //   );

  //   log("Basic notification shown");
  // }

  // show dummy orderd notifiacations
  static void showSingleNotification(String title, String body) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'default_channel',
      'Ordered Notification',
      channelDescription: 'Dummy order notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const NotificationDetails details = NotificationDetails(
      android: android,
    );
    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(10000);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      details,
      payload: "Payload Data",
    );
  }
}
