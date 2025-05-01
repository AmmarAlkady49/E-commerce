import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();
  final ProfilePageServices profilePageServices = ProfilePageServicesimpl();
  final secureStorage = SecureStorage();

  // Create Account
  Future<void> createAccount(
      {required String email,
      required String password,
      required String fName,
      required String lName,
      required String phone,
      required String birthDate}) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        name: "$fName $lName",
        email: email,
        password: password,
        phone: phone,
        birthOfDate: birthDate,
      );
      if (result) {
        // await _saveUserData(email, fName, lName, phone, birthDate);
        emit(CreatingAccoutSuccess());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError("An unexpected error occurred. Please try again."));
    }
  }

  // Login Account
  Future<void> loginAccount(String email, String password) async {
    emit(AuthLoading());
    try {
      final isLoginSuccessful =
          await authServices.loginWithEmailAndPassword(email, password);
      if (isLoginSuccessful) {
        final userData = await profilePageServices.getUserData();
        // Save user data to secure storage
        await secureStorage.saveSecureData("isLogin", "true");
        await secureStorage.saveSecureData("email", userData.email!);
        await secureStorage.saveSecureData("name", userData.name!);
        await secureStorage.saveSecureData("userId", userData.id!);
        // if (authServices.getCurrentUser()!.emailVerified) {
        emit(AuthSuccess());
        // } else {
        //   emit(AuthErrorVerification());
        // }
        log('Login successful');
      } else {
        log('Login failed');
        emit(AuthError(S.current.error_login));
      }
    } on Exception catch (e) {
      log('Login failed: $e');
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      log('Login failed: $e');
      return emit(AuthError(S.current.error_login));
    }
  }

  // get user Login or not
  Future<bool> isUserLogin() async {
    final isLogin = await secureStorage.readSecureData("isLogin") == "true";
    return isLogin;
  }

  // checkout account
  void checkAuth() async {
    // final user = await authServices.getUserProfile();
    // if (user != null) {
    //   emit(AuthSuccess());
    // }
    final isLogin = await isUserLogin();
    log(" isLogin ${isLogin.toString()}");
    if (isLogin) {
      emit(AuthSuccess());
    }
  }

  // void siginWithGoogle() async {
  //   emit(SigningWithGoogle());
  //   try {
  //     final result = await authServices.signinWithGoogle();
  //     if (result.user != null) {
  //       emit(SigningWithGoogleSuccess());
  //     } else {
  //       emit(SigningWithGoogleError(S.current.error_login));
  //     }
  //   } catch (e) {
  //     emit(SigningWithGoogleError(S.current.error_login));
  //   }
  // }
  void signinWithGoogle() async {
    emit(SigningWithGoogle());
    try {
      await authServices.signinWithGoogle();

      log('Google sign-in successful:');
      emit(SigningWithGoogleSuccess());
    } on Exception catch (e) {
      log('Google sign-in errorrrrr: $e');
      emit(
          SigningWithGoogleError(e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      log('Google sign-in errorororor: $e');
      emit(SigningWithGoogleError(e.toString()));
    }
  }

  void sendEmailForgetPassword(String emailText) async {
    emit(OTPCodeSending());
    try {
      await authServices.sendEmailForgetPassword(emailText);
      emit(OTPCodeSent());
    } on Exception catch (e) {
      emit(OTPCodeSendingError(e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      emit(OTPCodeSendingError(
          "An unexpected error occurred. Please try again."));
    }
  }

  void verifyOtpCode(String code, String email) async {
    emit(VerifyEmailLoading());
    try {
      final result = await authServices.verifyOtpCode(code, email);
      log(result.toString());
      if (result) {
        log('Verification successful');
        emit(VerifyOTPCodeSuccess());
      } else {
        emit(VerifyEmailError(S.current.error_verification_code));
      }
    } on Exception catch (e) {
      log('Error verifying email: $e');
      emit(VerifyEmailError(S.current.error_verification_code));
    } catch (e) {
      log('Error verifying email: $e');
      emit(VerifyEmailError(S.current.error_verification_code));
    }
  }

  // UpdatePassword Function
  Future<void> updatePassword(
      {required String newPassword, required String? email}) async {
    final String finalEmail =
        email ?? (await authServices.getUserProfile())?.email ?? '';

    emit(UpdateingPassword());
    try {
      final response = await authServices.resetPasword(finalEmail, newPassword);
      log(response.toString());
      if (response) {
        emit(UpdatePasswordSuccess());
      } else {
        log('Failed to update password');
        emit(UpdatePasswordError(message: "Failed to update password"));
      }
    } catch (e) {
      log('Failed to update password');
      log(e.toString());
      emit(UpdatePasswordError(message: e.toString()));
    }
  }

  // Active Account
  void activeAccount(String code, String email) async {
    emit(VerifyEmailLoading());
    try {
      final result = await authServices.verifyEmail(code, email);
      if (result) {
        emit(VerifyEmailSuccess());
      } else {
        emit(VerifyEmailError(S.current.error_verification_code));
      }
    } catch (e) {
      log('Error verifying email: $e');
      emit(VerifyEmailError(S.current.error_verification_code));
    }
  }

  // resend OtpCode
  void resendOtpCode(String email) async {
    emit(ResendOTPCodeLoading());
    log("OTP resend started");
    try {
      await authServices.resendOtpCode(email);
      log("OTP resend success");
      emit(ResendOTPCodeSuccess());
    } on Exception catch (e) {
      log("OTP resend error: $e");
      emit(ResendOTPCodeError(e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      log("Unexpected error: $e");
      emit(ResendOTPCodeError(
          "An unexpected error occurred. Please try again."));
    }
  }
}
