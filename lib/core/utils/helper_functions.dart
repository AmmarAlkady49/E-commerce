import 'package:e_commerce_graduation/features/home/model/category_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
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

  static String fixGoogleDriveUrl2(String url) {
    if (url.contains('drive.google.com')) {
      if (url.contains('open?id=')) {
        final fileId = url.split('id=').last;
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      } else if (url.contains('/file/d/') && url.contains('/view')) {
        final fileId = url.split('/file/d/').last.split('/view').first;
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
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

  static String formatNotificationTime(String isoTime, BuildContext context) {
    final now = DateTime.now();
    final messageTime = DateTime.tryParse(isoTime);

    if (messageTime == null) return isoTime;

    final difference = now.difference(messageTime);

    if (difference.inSeconds < 60) {
      return S.of(context).just_now;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${S.of(context).minutes_ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${S.of(context).hours_ago}';
    } else if (difference.inDays == 1) {
      return S.of(context).yesterday;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${S.of(context).days_ago}';
    } else {
      return DateFormat('MMM d, yyyy').format(messageTime);
    }
  }

  static Map<String, String> getAllCategoriesForHomePage(
      CategoryModel categoryItem) {
    switch (categoryItem.name) {
      case 'أرز و مكرونة و بقوليات':
        return {
          'name': 'أرز و مكرونة و بقوليات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/legumes.png',
        };

      case 'ادوات مكتبية':
        return {
          'name': 'أدوات مكتبية',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "U594M0",
          'imageUrl': 'assets/images/categories/Stationery.png',
        };
      case 'حلويات':
        return {
          'name': 'حلويات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/sweets.png',
        };
      case 'خضروات':
        return {
          'name': 'فاكهة و خضروات',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "J366R0",
          'imageUrl': 'assets/images/categories/fruits and vegetables.png',
        };
      case 'دخان':
        return {
          'name': 'دخان',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/cigarette pack.png',
        };
      case 'شيبس و مقبلات':
        return {
          'name': 'شيبسي و مقبلات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/Potato chips.png',
        };
      case 'عطارة':
        return {
          'name': 'عطارة',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/spices and seasonings.png',
        };
      case 'عناية شخصية':
        return {
          'name': 'عناية شخصية',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/Personal care.png',
        };
      case 'مأكولات بحرية':
        return {
          'name': 'مأكولات بحرية',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/seafood.png',
        };
      case 'مجمدات':
        return {
          'name': 'مجمدات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/frozen products.png',
        };
      case 'مستلزمات أطفال':
        return {
          'name': 'مستلزمات أطفال',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/Baby supplies.png',
        };
      case 'مستلزمات المطبخ':
        return {
          'name': 'مستلزمات المطبخ',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "U829D0",
          'imageUrl': 'assets/images/categories/kitchen supplies.png',
        };
      case 'مستلزمات منزلية':
        return {
          'name': 'مستلزمات منزلية',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "W389K0",
          'imageUrl':
              'assets/images/categories/household_supplies-removebg-preview.png',
        };
      case 'مشروبات':
        return {
          'name': 'مشروبات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/drinks.png',
        };
      case 'معلبات':
        return {
          'name': 'معلبات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/canned food.png',
        };

      case 'منتجات ألبان و بيض':
        return {
          'name': 'منتجات ألبان و بيض',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/dairy products and eggs.png',
        };

      case 'منتجات فطور غذائية':
        return {
          'name': 'منتجات غذائية',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "G555I0",
          'imageUrl':
              'assets/images/categories/Nutritional breakfast products.png',
        };

      case 'منظفات':
        return {
          'name': 'منظفات',
          'categoryCode': categoryItem.categoryCode,
          'imageUrl': 'assets/images/categories/detergents.png',
        };
      case 'اخري':
        return {
          'name': 'أكثر',
          'categoryCode': categoryItem.categoryCode,
          'categoryCode2': "NotFoundC",
          'imageUrl': 'assets/images/categories/others.png',
        };

      default:
        return {};
    }
  }
}
