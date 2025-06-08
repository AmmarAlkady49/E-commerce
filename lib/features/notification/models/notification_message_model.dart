// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class NotificationMessageModel {
  final String title;
  final String message;
  final String time;
  final IconData? icon;
  final bool isRead;

  NotificationMessageModel({
    required this.title,
    required this.message,
    required this.time,
    this.icon,
    this.isRead = false,
  });

  NotificationMessageModel copyWith({
    String? title,
    String? message,
    String? time,
    IconData? icon,
    bool? isRead,
  }) {
    return NotificationMessageModel(
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      icon: icon ?? this.icon,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'time': time,
      'icon': icon?.codePoint,
      'isRead': isRead,
    };
  }

  factory NotificationMessageModel.fromMap(Map<String, dynamic> map) {
    return NotificationMessageModel(
      title: map['title'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      isRead: map['isRead'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMessageModel.fromJson(String source) =>
      NotificationMessageModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

// final List<List<String>> dummyRepeatedNotificationList = [
//   [
//     '🍲 فيه عزومة؟',
//     ' عندنا كل اللي محتاجاه علشان تعملي أحلى سفرة من غير طلعة واحدة 🛒✨',
//   ],
//   [
//     '🛍️ شوفتي العروض النهارده؟',
//     'خصومات مجنونة على منتجاتك المفضلة 👀 سريعي قبل ما تخلص 🕒',
//   ],
//   [
//     '🧼 عايزة تنضفي بيتك بسهولة؟',
//     ' أدوات تنظيف، معطرات، ومنتجات مميزة توصلك لحد باب البيت 🧽🚪',
//   ],
//   [
//     '🥦 خضارك فريش وجاهز!',
//     'اطلب دلوقتي خضار فريش يتغسل ويتقطع ويوصلك وانتِ في بيتك 🥬📦',
//   ],
//   [
//     '👗 لسه مستنية إيه؟',
//     ' فاشون، بيوتي، وإكسسوارات بأسعار ولا في الأحلام! 💅💃',
//   ],
//   [
//     '🔥 عرض اليوم بس!',
//     'خصم %50 على منتجات مختارة. اضغطي وشوفي إيه اللي مستنيكي 🎉🛍️',
//   ],
//   [
//     '🍋 نظافة وانتعاش؟',
//     'منظفات، معطرات، وكل اللي بيتك محتاجه بتوصيل سريع 🚚✨',
//   ],
//   [
//     '🍅 طبختك جاهزة!',
//     'اطلبي خضارك متقطع ومغسول ووفرنا عليكي الوقت 💚🥬',
//   ],
//   [
//     '💅 وقت الدلع؟',
//     'طلبي مستحضرات التجميل اللي بتحبيها بأسعار تنافسية 💖',
//   ],
//   [
//     '🎉 شكراً لولائك!',
//     'عندك خصم حصري على طلبك الجاي! استخدمي الكود: WELCOME10 🎁',
//   ],
//   [
//     '⌛ لسه بتفكري؟',
//     'المنتج اللي شفتيه من شوية قرب يخلص من المخزون! 🛒😱',
//   ],
//   [
//     '😱 الجمعة جاية؟',
//     ' جهزي عزومتك بكل سهولة.. الأكل، الحلويات، والمشروبات عندنا! 🥘🧃',
//   ],
//   [
//     'مفيش وقت تنزلي؟ 🕒',
//     'عندنا كل حاجة من غير مشوار! 🛍️🚗',
//   ],
//   [
//     'الغسيل اتأخر؟ 🧺',
//     'مساحيق، منعمات، وريحتهم تفضل فايحة! ✨ اطلب دلوقتي 🧼',
//   ],
//   [
//     ' الشاي خلص؟ 😱',
//     'متقلقش! اطلب اللي ناقصك من غير ما تتحرك من مكانك! 🍵📦',
//   ],
//   [
//     'الجو حر؟ 🥵',
//     'ايس كريم، عصاير، ومياه ساقعة توصلك وانت قاعد تحت التكييف! 🍦🧃',
//   ],
//   [
//     'الفطار كان تقيل 🤕',
//     'شوية رايب و الموضوع يخلص! 🥛 اطلب كل اللي نفسك فيه، وهيجيلك هوا! 🚀',
//   ],
// ];
