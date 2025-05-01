import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/customer_data.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ProfilePageServices {
  Future<void> signOut();
  Future<void> signoutFromGoogle();
  Future<bool> verifyOtpCode(String email, String otpCode);
  // Future<void> updatePassword(String newPassword, String otpCode, String email);
  Future<CustomerData> getUserData();
  Future<bool> updateUserData(CustomerData userData);
}

class ProfilePageServicesimpl implements ProfilePageServices {
  final secureStorage = SecureStorage();
  final aDio = Dio();
  @override
  Future<void> signOut() async {
    await aDio.post(
      "${AppConstants.baseUrl}${AppConstants.logout}",
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${await secureStorage.readSecureData('token')}",
        },
      ),
    );
    await secureStorage.deleteSecureData('token');
    await secureStorage.saveSecureData("isLogin", "false");
  }

  @override
  Future<void> signoutFromGoogle() async {
    await GoogleSignIn().signOut();
    await secureStorage.deleteSecureData('token');
    await secureStorage.saveSecureData("isLogin", "false");
  }

  @override
  Future<bool> verifyOtpCode(String email, String otpCode) async {
    // final userData = await getUserData();
    final apiRespons = await aDio.post(
      "${AppConstants.baseUrl}${AppConstants.verifyOtp}",
      data: {
        "email": email,
        "code": otpCode,
      },
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${await secureStorage.readSecureData('token')}",
        },
      ),
    );
    if (apiRespons.statusCode == 200) {
      return true;
    } else if (apiRespons.statusCode == 400) {
      throw Exception("Bad request: ${apiRespons.data}");
    } else {
      throw Exception("Failed to verify otp: ${apiRespons.statusCode}");
    }
  }

  @override
  Future<CustomerData> getUserData() async {
    final tooken = await secureStorage.readSecureData("token");
    final userDataResponse = await aDio.get(
      "${AppConstants.baseUrl}${AppConstants.accountProfile}",
      options: Options(
        headers: {"Authorization": "Bearer $tooken"},
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (userDataResponse.statusCode == 200) {
      final userData = CustomerData.fromMap(userDataResponse.data);

      return userData;
    } else if (userDataResponse.statusCode == 400) {
      throw Exception("Bad request: ${userDataResponse.data}");
    } else {
      throw Exception("Failed to load user data");
    }
  }

  @override
  Future<bool> updateUserData(CustomerData userData) async {
    final apiResponse = await aDio.put(
      "${AppConstants.baseUrl}${AppConstants.editProfile}",
      data: userData.toMap(),
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${await secureStorage.readSecureData('token')}",
        },
      ),
    );
    if (apiResponse.statusCode == 200) {
      return true;
    } else if (apiResponse.statusCode == 400) {
      throw Exception("Bad request: ${apiResponse.data}");
    } else {
      throw Exception("Failed to update user data");
    }
  }

  // @override
  // Future<void> updatePassword(
  //     String newPassword, String otpCode, String email) async {
  //   final apiRespons = await aDio.post(
  //     "${AppConstants.baseUrl}${AppConstants.verifyOtp}",
  //     data: {
  //       "email": email,
  //       "code": otpCode,
  //       "newPassword": newPassword,
  //     },
  //     options: Options(
  //       headers: {
  //         "Authorization":
  //             "Bearer ${await secureStorage.readSecureData('token')}",
  //       },
  //     ),
  //   );
  //   if (apiRespons.statusCode == 200) {
  //     return apiRespons.data;
  //   } else if (apiRespons.statusCode == 400) {
  //     throw Exception("Bad request: ${apiRespons.data}");
  //   } else {
  //     throw Exception("Failed to verify otp: ${apiRespons.statusCode}");
  //   }
  // }
}
