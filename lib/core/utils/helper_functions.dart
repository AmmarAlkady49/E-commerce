import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static String fixGoogleDriveUrl(String url) {
    if (url.contains('drive.google.com') && url.contains('open?id=')) {
      final fileId = url.split('id=').last;
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }
    return url;
  }

  static String formatArabicDate(String dateStr, {String lang = 'ar'}) {
    try {
      final parsedDate =
          DateFormat("M/d/yyyy h:mm:ss a", "en_US").parse(dateStr);

      const List<String> arabicMonths = [
        "يناير",
        "فبراير",
        "مارس",
        "ابريل",
        "مايو",
        "يونيو",
        "يوليو",
        "أغسطس",
        "سبتمبر",
        "أكتوبر",
        "نوفمبر",
        "ديسمبر"
      ];

      const List<String> englishMonths = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];

      final day = parsedDate.day;
      final month = lang == 'ar'
          ? arabicMonths[parsedDate.month - 1]
          : englishMonths[parsedDate.month - 1];

      return "$day $month";
    } catch (e) {
      return lang == 'ar' ? "تاريخ غير صالح" : "Invalid date";
    }
  }

  static bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar' ? true : false;
  }

  static String getLocalizedOrderStatus(String status, {String lang = 'ar'}) {
    final statusLower = status.toLowerCase();
    if (lang == 'ar') {
      switch (statusLower) {
        case 'pending':
          return 'قيد الإنتظار';
        case 'shipped':
          return 'تم الشحن';
        case 'delivered':
          return 'تم التسليم';
        case 'paymentfailed':
          return 'فشل الدفع';
        default:
          return status;
      }
    } else {
      // English or fallback
      return status[0].toUpperCase() + status.substring(1);
    }
  }

  static Color getOrderStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'paymentfailed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
