import 'package:e_commerce_graduation/features/home/model/category_model.dart';
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

  // static Map<String, String> getAllCategoriesForHomePage(
  //     CategoryModel categoryItem) {
  //   switch (categoryItem.name) {
  //     case 'أرز و مكرونة و بقوليات':
  //       return {
  //         'name': 'أرز و مكرونة و بقوليات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             // 'https://drive.google.com/file/d/1LT176UypGKqmwsolo8IR-VPQFpyqkUql/view?usp=sharing',
  //             'https://drive.google.com/file/d/1LT176UypGKqmwsolo8IR-VPQFpyqkUql/view?usp=sharing',
  //       };
  //     case 'اخري':
  //       return {
  //         'name': 'أكثر',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "NotFoundC",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1_r-RddCnTVuo-8flYAfvWoRZdycyahKZ/view?usp=sharing',
  //       };
  //     // case 'ادوات مطبخ':
  //     //   return {
  //     //     'name': 'ادوات مطبخ',
  //     //     'categoryCode': categoryItem.categoryCode,
  //     //     'imageUrl':
  //     //         'https://drive.google.com/file/d/1G48PU2qQAECySUTUsgXiRoSuFybeeGGE/view?usp=sharing',
  //     //   };
  //     case 'ادوات مكتبية':
  //       return {
  //         'name': 'ادوات مكتبية',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "U594M0",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1SqWCG59YW1YGqAYEohc88UkXKEbDpRMI/view?usp=sharing',
  //       };
  //     case 'حلويات':
  //       return {
  //         'name': 'حلويات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1w5gw35QopOxi1iuWs_7mcPZzPbi4ewJn/view?usp=sharing',
  //       };
  //     case 'خضروات':
  //       return {
  //         'name': 'فاكهة و خضروات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "J366R0",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1pQmkC_UAaEYVAFeiT5_uVH9Dv5_LCSIv/view?usp=sharing',
  //       };
  //     // case 'فاكهة':
  //     //   return {
  //     //     'name': 'فاكهة',
  //     //     'categoryCode': categoryItem.categoryCode,
  //     //     'imageUrl':
  //     //         'https://drive.google.com/file/d/1dY7lL4-ci_oCA2PbI9ypYW5CA3x7cuRU/view?usp=sharing',
  //     //   };
  //     case 'دخان':
  //       return {
  //         'name': 'دخان',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1iG4msnL1kBmAUXMwwosGv28kk1jnq6xP/view?usp=sharing',
  //       };
  //     case 'شيبس و مقبلات':
  //       return {
  //         'name': 'شيبس و مقبلات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1LRedZlCwKyULoayniCzWc0_hK8PPz1uW/view?usp=sharing',
  //       };
  //     case 'عطارة':
  //       return {
  //         'name': 'عطارة',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1hLyszF4MpRTP_HvPiBJJzaZfNPn2gB25/view?usp=sharing',
  //       };
  //     case 'عناية شخصية':
  //       return {
  //         'name': 'عناية شخصية',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1MO_kScL__fSWTMrAfqEWKennDY1hyK6O/view?usp=sharing',
  //       };
  //     case 'مأكولات بحرية':
  //       return {
  //         'name': 'مأكولات بحرية',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/14emVuweULP6N3LBZ2r0n--TB1RMaglNA/view?usp=sharing',
  //       };
  //     case 'مجمدات':
  //       return {
  //         'name': 'مجمدات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1WUiqpgL9dfbeVQAf6kTc4Axk_wj4yFeY/view?usp=sharing',
  //       };
  //     case 'مستلزمات أطفال':
  //       return {
  //         'name': 'مستلزمات أطفال',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/16JPOElPqw7a6-89r2r-AY6aMYHRWQWXv/view?usp=sharing',
  //       };
  //     case 'مستلزمات المطبخ':
  //       return {
  //         'name': 'مستلزمات المطبخ',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "U829D0",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1WYcbzvjSdRulOWcGSolglvWdFDEzhG6k/view?usp=sharing',
  //       };
  //     case 'مستلزمات منزلية':
  //       return {
  //         'name': 'مستلزمات منزلية',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "W389K0",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1XM3zwLL0Kl8mV54pDG8rMqyTjx64LUXr/view?usp=sharing',
  //       };
  //     case 'مشروبات':
  //       return {
  //         'name': 'مشروبات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1WFneML_lc2IBUht0B3oB5BK2xgl_3xJ-/view?usp=sharing',
  //       };
  //     case 'معلبات':
  //       return {
  //         'name': 'معلبات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1wltBW1O7FOHfERd-D2s7j8pdtOGXv_i0/view?usp=sharing',
  //       };
  //     // case 'مكونات الطبخ':
  //     //   return {
  //     //     'name': 'مكونات الطبخ',
  //     //     'categoryCode': categoryItem.categoryCode,
  //     //     'imageUrl':
  //     //         'https://drive.google.com/file/d/1C1DKNp0jSbY5fZv5sx6kR8scHMcMX-Pe/view?usp=sharing',
  //     //   };
  //     case 'منتجات ألبان و بيض':
  //       return {
  //         'name': 'منتجات ألبان و بيض',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1hwbKzYAmqFAmq9Kz4sqMzfo5F8HY7J3Y/view?usp=sharing',
  //       };
  //     // case 'منتجات سريعة التحضير و سكر':
  //     //   return {
  //     //     'name': 'منتجات سريعة التحضير و سكر',
  //     //     'categoryCode': categoryItem.categoryCode,
  //     //     'imageUrl':
  //     //         'https://drive.google.com/file/d/1G48PU2qQAECySUTUsgXiRoSuFybeeGGE/view?usp=sharing',
  //     //   };
  //     case 'منتجات فطور غذائية':
  //       return {
  //         'name': 'منتجات غذائية',
  //         'categoryCode': categoryItem.categoryCode,
  //         'categoryCode2': "G555I0",
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1tiQg18uaHW8bwZSn7XU_LhxfHe4fXjVq/view?usp=sharing',
  //       };
  //     // case 'منتجات مكتبية':
  //     //   return {
  //     //     'name': 'منتجات مكتبية',
  //     //     'categoryCode': categoryItem.categoryCode,
  //     //     'imageUrl':
  //     //         'https://drive.google.com/file/d/1j2HjeFc7t1WRUzcniZoz9S-VjhkahEpc/view?usp=sharing',
  //     //   };
  //     case 'منظفات':
  //       return {
  //         'name': 'منظفات',
  //         'categoryCode': categoryItem.categoryCode,
  //         'imageUrl':
  //             'https://drive.google.com/file/d/1kSeFNrsaBntfxTN_9cMIvzkgx3hQC4EY/view?usp=sharing',
  //       };
  //     // case 'no category':
  //     //   return {
  //     //     // 'name': 'لا يوجد فئة',
  //     //     // 'categoryCode': categoryItem.categoryCode,
  //     //     // 'imageUrl':
  //     //     //     'https://drive.google.com/file/d/1_r-RddCnTVuo-8flYAfvWoRZdycyahKZ/view?usp=sharing',
  //     //   };

  //     default:
  //       return {};
  //   }
  // }
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
          'name': 'ادوات مكتبية',
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
          'name': 'شيبس و مقبلات',
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
