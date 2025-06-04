import 'dart:developer';

import 'package:e_commerce_graduation/core/models/customer_data.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final CartCubit cartCubit;
  final FavoritesCubit favoritesCubit;
  final HomeCubit homeCubit;
  ProfileCubit(
      {required this.cartCubit,
      required this.favoritesCubit,
      required this.homeCubit})
      : super(ProfileInitial());

  final ProfilePageServices _profileAuthServices = ProfilePageServicesimpl();
  final AuthServices authServices = AuthServicesImpl();
  late CustomerData currentUserData;
  final secureStorage = SecureStorage();
  bool activeNotifications = true;
  bool hasFetchedUserData = false;

  // LogOut Function
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    emit(ProfileLogingOut());
    try {
      await _profileAuthServices.signOut();
      await _profileAuthServices.signoutFromGoogle();
      await pref.setBool('rememberMe', false);
      await secureStorage.deleteSecureData('token');
      await secureStorage.deleteSecureData('email');
      await secureStorage.deleteSecureData('userId');
      await secureStorage.deleteSecureData('photoUrl');
      await secureStorage.deleteSecureData('name');
      await secureStorage.deleteSecureData('isLogin');
      hasFetchedUserData = false;
      favoritesCubit.hasFetchedFavorites = false;
      cartCubit.hasFetchedCart = false;
      homeCubit.hasFetchedRecommendedProducts = false;
      emit(ProfileLogedOut());
    } catch (e) {
      emit(ProfileLogOutError(message: e.toString()));
    }
  }

  // active Notifications Function
  Future<void> activeNotification() async {
    activeNotifications = !activeNotifications;
  }

  // GetUserData Function
  Future<CustomerData?> getUserData() async {
    log("$hasFetchedUserData");
    if (hasFetchedUserData) {
      log("User data already fetched, returning cached data.");
      emit(AccountPageLoaded(
        email: currentUserData.email ?? "null",
        fName: currentUserData.name != null
            ? currentUserData.name!.trim().split(" ").first
            : "null",
        lName: currentUserData.name != null
            ? currentUserData.name!.trim().split(" ").last
            : "null",
        phone: currentUserData.phoneNumber ?? "null",
        gender: currentUserData.gender ?? "male",
        birthDate: currentUserData.dateOfBirth ?? "null",
        photoUrl: await secureStorage.readSecureData("photoUrl"),
      ));
      return currentUserData;
    }
    emit(AccountPageLoading());
    log("Fetching user data from the server...");
    try {
      final CustomerData userData = await _profileAuthServices.getUserData();
      final photoUrl = await secureStorage.readSecureData("photoUrl");
      hasFetchedUserData = true;
      log("$hasFetchedUserData");
      emit(
        AccountPageLoaded(
          email: userData.email != null ? userData.email! : "null",
          fName: userData.name != null
              ? userData.name!.trim().split(" ").first
              : "null",
          lName: userData.name != null
              ? userData.name!.trim().split(" ").last
              : "null",
          phone: userData.phoneNumber != null ? userData.phoneNumber! : "null",
          gender: userData.gender != null ? userData.gender! : "male",
          birthDate:
              userData.dateOfBirth != null ? userData.dateOfBirth! : "null",
          photoUrl: photoUrl,
        ),
      );
      currentUserData = userData;
      // log("User Data: ${userData.toMap()}");
      log("$hasFetchedUserData");
    } on Exception catch (e) {
      emit(AccountPageError(message: e.toString()));
    } catch (e) {
      log("Error: $e");
      emit(AccountPageError(message: e.toString()));
    }
    return null;
  }

  // UpdateUserData Function
  Future<void> updateUserData(CustomerData userData) async {
    emit(AccountPageLoading());
    try {
      final response = await _profileAuthServices.updateUserData(userData);
      final photoUrl = await secureStorage.readSecureData("photoUrl");

      if (response) {
        final newUserData = await _profileAuthServices.getUserData();
        hasFetchedUserData = false;
        emit(
          AccountPageLoaded(
            email: newUserData.email != null ? newUserData.email! : "null",
            fName: newUserData.name != null
                ? newUserData.name!.trim().split(" ").first
                : "null",
            lName: newUserData.name != null
                ? newUserData.name!.trim().split(" ").last
                : "null",
            phone: newUserData.phoneNumber != null
                ? newUserData.phoneNumber!
                : "null",
            gender: newUserData.gender != null ? newUserData.gender! : "null",
            birthDate: newUserData.dateOfBirth != null
                ? newUserData.dateOfBirth!
                : "null",
            photoUrl: photoUrl,
          ),
        );
        await secureStorage.saveSecureData("name", newUserData.name!);
        await secureStorage.saveSecureData('gender', newUserData.gender!);
      } else {
        emit(AccountPageError(message: "Failed to update user data"));
      }
    } on Exception catch (e) {
      log("Error: $e");
      emit(AccountPageError(message: e.toString()));
    } catch (e) {
      emit(AccountPageError(message: e.toString()));
    }
  }

  // // get email from secure storage
  // Future<String?> getEmail() async {
  //   final email = await secureStorage.readSecureData('email');
  //   log("Email from secure storage: $email");
  //   return email;
  // }
}
