import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  // Create Account
  Future<void> createAccount(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
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
    }
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
    emit(updatingPassword());
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
