import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/customer_data.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthOfDate,
  });
  Future<CustomerData?> getUserProfile();
  Future<bool> verifyEmail(String code, String email);
  Future<bool> verifyOtpCode(String email, String otpCode);
  Future<bool> resendOtpCode(String email);
  Future<bool> resetPasword(String email, String password);
  Future<void> signoutFromGoogle();
  Future<void> signinWithGoogle();
  Future<bool> sendEmailForgetPassword(String emailText);
}

class AuthServicesImpl implements AuthServices {
  final aDio = Dio();
  final secureStorage = SecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: AppConstants.googleClientId,
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
          await secureStorage.saveSecureData('isLogin', 'true');
          await secureStorage.saveSecureData('email', email);
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
  Future<bool> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthOfDate,
  }) async {
    final customerData = CustomerData(
      name: name,
      email: email,
      password: password,
      phoneNumber: phone,
      dateOfBirth: birthOfDate,
    );
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
  Future<void> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return Future.error('Google sign-in aborted');
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final String? idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('Failed to get ID token');
    }
    final apiResponse = await aDio.post(
      "${AppConstants.baseUrl}${AppConstants.mobileGoogleLogin}",
      data: {
        "idToken": idToken,
      },
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    log(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      log('Google sign-in successful: ${apiResponse.data}');
      final responseMessage = apiResponse.data;
      if (responseMessage != null) {
        await secureStorage.saveSecureData('token', responseMessage['token']);
        await secureStorage.saveSecureData('isLogin', 'true');
        await secureStorage.saveSecureData('email', googleUser.email);
        await secureStorage.saveSecureData('id', googleUser.id);
      }
    } else if (apiResponse.statusCode == 400) {
      throw Exception(apiResponse.data['message'] ?? 'Failed to login');
    } else {
      log('Failed to login: ${apiResponse.statusCode}');
      throw Exception('Failed to login: ${apiResponse.statusCode}');
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
