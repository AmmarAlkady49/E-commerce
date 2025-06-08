import 'dart:convert';
import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorage {
  static const _key = 'notifications_list';

  static Future<void> saveNotification(NotificationMessageModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await loadNotifications();

    list.insert(0, model); // newest at the top

    final jsonList = list.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<NotificationMessageModel>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList
        .map((e) => NotificationMessageModel.fromJson(json.decode(e)))
        .toList();
  }

  static Future<void> clearNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
