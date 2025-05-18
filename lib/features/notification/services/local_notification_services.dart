import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}
  static Future initNitification() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
    log(" Notification initialized");
  }

  // show basic notification
  static void showBasicNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        'Basic Notifications',
        channelDescription: 'Channel for showing basic notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
      ),
    );

    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(10000);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      ' جدا طلب جديد',
      'تم استلام طلب جديد من المستخدم طلب جديد',
      notificationDetails,
    );

    log("Basic notification shown");
  }

  // show dummy orderd notifiacations
  static void showSingleNotification(String title, String body) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'Ordered Notification',
      channelDescription: 'Dummy order notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const NotificationDetails details = NotificationDetails(android: android);
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
