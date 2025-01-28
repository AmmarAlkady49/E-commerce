import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      emit(AuthSuccess());
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthError('Faild to create account'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return emit(AuthError(S.current.weak_password));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return emit(AuthError(S.current.account_exists));
      }
    } catch (e) {
      print(e);
    }
  }

  // Login Account
  Future<void> loginAccount(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.loginWithEmailAndPassword(email, password);
      emit(AuthSuccess());
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthError('Faild to login account'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
