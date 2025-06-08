import 'dart:developer';

import 'package:e_commerce_graduation/core/utils/themes/notification_storage.dart';
import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationServices {
  Future<void> initNotificationsFirebase();
  Future<void> initNotificationLocal();
  Future<void> initPushNotifications();
  void handleMessage(RemoteMessage? message);
}

class NotificationServicesImpl implements NotificationServices {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Future<void> initNotificationsFirebase() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    log("Firebase Messaging Token: $fCMToken");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification?.title ?? 'No title';
      final body = message.notification?.body ?? 'No body';
      final now = DateTime.now().toIso8601String();

      // Save to local storage
      final notification = NotificationMessageModel(
        title: title,
        message: body,
        time: now,
        icon: Icons.notifications,
      );
      await NotificationStorage.saveNotification(notification);

      // Show notification
      flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });

    await initPushNotifications();
  }

  @override
  Future<void> initNotificationLocal() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> initPushNotifications() {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    return Future.value();
  }

  @override
  void handleMessage(RemoteMessage? message) async {
    if (message != null) {
      final title = message.notification?.title ?? 'No title';
      final body = message.notification?.body ?? 'No body';
      final now = DateTime.now().toIso8601String();

      // Save to local storage
      final notification = NotificationMessageModel(
        title: title,
        message: body,
        time: now,
        icon: Icons.notifications,
      );
      await NotificationStorage.saveNotification(notification);

      log("Message received and saved: $title");
    } else {
      log("No message received");
    }
  }
}
