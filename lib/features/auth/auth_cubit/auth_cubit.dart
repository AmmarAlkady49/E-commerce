import 'package:e_commerce_graduation/core/models/user_data.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();
  final fireStoreServices = FirestoreServices.instance;

  // Create Account
  Future<void> createAccount({
    required String email,
    required String password,
    required String fName,
    required String lName,
    required String phone,
    required String birthDate,
  }) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
        await _saveUserData(email, fName, lName, phone, birthDate);
        emit(CreatingAccoutSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return emit(AuthError(S.current.weak_password));
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return emit(AuthError(S.current.account_exists));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  // save user date
  Future<void> _saveUserData(
    String email,
    String fName,
    String lName,
    String phone,
    String birthDate,
  ) async {
    final currentUser = authServices.getCurrentUser();
    final userData = UserData(
        uid: currentUser!.uid,
        email: email,
        firstName: fName,
        lasttName: lName,
        birthDate: birthDate,
        phoneNumber: phone,
        createdAt: DateTime.now().toIso8601String());
    await fireStoreServices.setData(
      path: ApiPathes.users(userData.uid),
      data: userData.toMap(),
    );
  }

  // Login Account
  Future<void> loginAccount(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        if (authServices.getCurrentUser()!.emailVerified) {
          emit(AuthSuccess());
        } else {
          emit(AuthErrorVerification());
        }
      } else {
        emit(AuthError(S.current.error_login));
      }
    } catch (e) {
      return emit(AuthError(S.current.error_login));
    }
  }

  // checkout account
  void checkAuth() {
    final user = authServices.getCurrentUser();
    if (user != null && user.emailVerified) {
      emit(AuthSuccess());
    }
  }

  // send email verification
  void sendEmailVerification() {
    try {
      authServices.sendEmailVerification();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // sign out
  void signOut() async {
    emit(LoggingOut());
    try {
      await authServices.signoutFromGoogle();
      await authServices.signOut();
      emit(LoggedOut());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }

  void siginWithGoogle() async {
    emit(SigningWithGoogle());
    try {
      final result = await authServices.signinWithGoogle();
      if (result.user != null) {
        emit(SigningWithGoogleSuccess());
      } else {
        emit(SigningWithGoogleError(S.current.error_login));
      }
    } catch (e) {
      emit(SigningWithGoogleError(S.current.error_login));
    }
  }

  void updatePassword(String emailText) async {
    emit(UpdatingPassword());
    try {
      await authServices.updatePassword(emailText);
      emit(PasswordUpdated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(PasswordUpdateError(S.current.invalid_email));
      }
    } catch (e) {
      emit(PasswordUpdateError(S.current.error_reset_password));
    }
  }
}
