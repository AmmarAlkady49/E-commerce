import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';

abstract class AppServices {
  Future<bool> editAccountProfile({
    required String name,
    required String email,
    required String address,
    required String city,
    required String country,
    required String postalCode,
    required String phoneNumber,
    required String gender,
    required String dateOfBirth,
  });
}

class AppServicesImpl implements AppServices {
  final aDio = Dio();
  final secureStorage = SecureStorage();
  @override
  Future<bool> editAccountProfile(
      {required String name,
      required String email,
      required String address,
      required String city,
      required String country,
      required String postalCode,
      required String phoneNumber,
      required String gender,
      required String dateOfBirth}) async {
    try {
      final apiResponse = await aDio.put(
        "${AppConstants.baseUrl}${AppConstants.editAccountProfile}",
        data: {
          "name": name,
          "email": email,
          "address": address,
          "city": city,
          "country": country,
          "postalCode": postalCode,
          "phoneNumber": phoneNumber,
          "gender": gender,
          "dateOfBirth": dateOfBirth,
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}"
          },
        ),
      );
      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 400) {
        throw Exception(
            apiResponse.data['message'] ?? 'Failed to update profile');
      } else if (apiResponse.statusCode == 401) {
        throw Exception(apiResponse.data['message'] ?? 'Unauthorized access');
      } else {
        log('Failed to update profile: ${apiResponse.statusCode}');
        throw Exception('Failed to update profile: ${apiResponse.statusCode}');
      }
    } catch (e) {
      return throw Exception('Failed to update profile: $e');
    }
  }
}
