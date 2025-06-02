import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/customer_data.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String birthOfDate,
      required String gender});
  Future<CustomerData?> getUserProfile();
  Future<bool> verifyEmail(String code, String email);
  Future<bool> verifyOtpCode(String email, String otpCode);
  Future<bool> resendOtpCode(String email);
  Future<bool> resetPasword(String email, String password);
  Future<void> signoutFromGoogle();
  Future<GoogleSignInAccount?> signinWithGoogle();
  Future<bool> sendEmailForgetPassword(String emailText);
}

class AuthServicesImpl implements AuthServices {
  final aDio = Dio();
  final secureStorage = SecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // serverClientId: AppConstants.webClientId,
    serverClientId: dotenv.env['WEB_CLIENT_ID'],
    scopes: [
      'email',
      'profile',
      'openid',
    ],
  );

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      final apiResponse = await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.login}",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (apiResponse.statusCode == 200) {
        final responseMessage = apiResponse.data['message'];
        if (responseMessage != null) {
          await secureStorage.saveSecureData('token', responseMessage);
          return true;
        } else {
          return false;
        }
      } else if (apiResponse.statusCode == 400) {
        throw Exception(apiResponse.data['message'] ?? 'Failed to login');
      } else {
        log('Failed to login: ${apiResponse.statusCode}');
        throw Exception('Failed to login: ${apiResponse.statusCode}');
      }
    } catch (e) {
      return throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String birthOfDate,
      required String gender}) async {
    final customerData = CustomerData(
        name: name,
        email: email,
        password: password,
        phoneNumber: phone,
        dateOfBirth: birthOfDate,
        gender: gender);
    final apiResponse =
        await aDio.post("${AppConstants.baseUrl}${AppConstants.register}",
            data: customerData.toMap(),
            options: Options(
              validateStatus: (status) => status != null && status < 500,
            ));
    if (apiResponse.statusCode == 200) {
      if (apiResponse.data['message'] != null) {
        return true;
      } else {
        return false;
      }
    } else if (apiResponse.statusCode == 400) {
      throw Exception(apiResponse.data['message'] ?? 'Failed to register');
    } else {
      log('Failed to register: ${apiResponse.statusCode}');
      throw Exception('Failed to register: ${apiResponse.statusCode}');
    }
  }

  @override
  Future<CustomerData?> getUserProfile() async {
    try {
      final getUserProfileResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.accountProfile}",
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
      );
      // log(getUserProfileResponse.data);
      return getUserProfileResponse.data['message'] != null
          ? CustomerData.fromMap(getUserProfileResponse.data['message'])
          : null;
    } catch (e) {
      log('Error getting user profile: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  // @override
  // Future<UserCredential> signinWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   if (googleUser == null) {
  //     return Future.error('Google sign-in aborted');
  //   }
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  @override
  Future<GoogleSignInAccount?> signinWithGoogle() async {
    try {
      log('[GoogleSignIn] Starting sign-in');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log('[GoogleSignIn] User aborted sign-in');
        throw Exception('Google sign-in aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? serverAuthCode = googleUser.serverAuthCode;

      if (idToken == null && serverAuthCode == null) {
        throw Exception('Google sign-in failed: No ID token or auth code');
      }

      final dataToSend = idToken != null
          ? {'idToken': idToken}
          : {'serverAuthCode': serverAuthCode};

      final response = await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.mobileGoogleLogin}",
        data: dataToSend,
        options:
            Options(validateStatus: (status) => status != null && status < 500),
      );

      if (response.statusCode == 200 && response.data is Map) {
        final responseData = response.data;
        final token = responseData['token'];
        if (token != null) {
          await secureStorage.saveSecureData('token', token);
          return googleUser;
        }
      }

      final message = response.data['message'] ?? 'Unknown error';
      throw Exception('Google sign-in failed: $message');
    } catch (e, stack) {
      log('[GoogleSignIn] ERROR: $e');
      log('[GoogleSignIn] STACK TRACE:\n$stack');
      rethrow;
    }
  }

  @override
  Future<void> signoutFromGoogle() {
    return _googleSignIn.signOut();
  }

  @override
  Future<bool> sendEmailForgetPassword(String emailText) async {
    final apiResponse = await aDio.get(
      "${AppConstants.baseUrl}${AppConstants.sendEmailForgetPassword}",
      queryParameters: {
        "email": emailText,
      },
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (apiResponse.statusCode == 200) {
      return true;
    } else if (apiResponse.statusCode == 400) {
      throw Exception(apiResponse.data['message'] ?? 'Failed to register');
    } else {
      log('Failed to register: ${apiResponse.statusCode}');
      throw Exception('Failed to register: ${apiResponse.statusCode}');
    }
  }

  @override
  Future<bool> verifyOtpCode(String email, String otpCode) async {
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
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (apiRespons.statusCode == 200) {
      await secureStorage.saveSecureData('otpCode', otpCode);
      return true;
    } else if (apiRespons.statusCode == 400) {
      throw Exception("Bad request: ${apiRespons.data}");
    } else {
      throw Exception("Failed to verify otp: ${apiRespons.statusCode}");
    }
  }

  @override
  Future<bool> verifyEmail(String code, String email) async {
    final response = await aDio.post(
      "${AppConstants.baseUrl}${AppConstants.activeAccount}",
      data: {
        "email": email,
        "code": code,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> resetPasword(String email, String password) async {
    final code = await secureStorage.readSecureData('otpCode');
    final apiResponse = await aDio.post(
      "${AppConstants.baseUrl}${AppConstants.resetPasswort}",
      data: {
        "email": email,
        "password": password,
        "code": code,
      },
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${await secureStorage.readSecureData('token')}",
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    await secureStorage.deleteSecureData('otpCode');
    if (apiResponse.statusCode == 200) {
      return true;
    } else if (apiResponse.statusCode == 400) {
      throw Exception(apiResponse.data['message'] ?? 'Failed to register');
    } else {
      log('Failed to register: ${apiResponse.statusCode}');
      throw Exception('Failed to register: ${apiResponse.statusCode}');
    }
  }

  @override
  Future<bool> resendOtpCode(String email) async {
    final apiResponse =
        await aDio.post("${AppConstants.baseUrl}${AppConstants.resendOtp}",
            data: {
              "email": email,
            },
            options: Options(
              headers: {
                "Authorization":
                    "Bearer ${await secureStorage.readSecureData('token')}",
              },
              validateStatus: (status) => status != null && status < 500,
            ));
    if (apiResponse.statusCode == 200) {
      return true;
    } else if (apiResponse.statusCode == 400) {
      throw Exception(apiResponse.data['message'] ?? 'Failed to register');
    } else {
      log('Failed to register: ${apiResponse.statusCode}');
      throw Exception('Failed to register: ${apiResponse.statusCode}');
    }
  }
}
