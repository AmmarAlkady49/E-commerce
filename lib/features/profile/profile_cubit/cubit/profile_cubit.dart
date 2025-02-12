import 'package:e_commerce_graduation/core/models/user_data.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final ProfilePageServices _profileAuthServices = ProfilePageServicesimpl();

  // LogOut Function
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    emit(ProfileLogingOut());
    try {
      await _profileAuthServices.signOut();
      await _profileAuthServices.signoutFromGoogle();
      await pref.setBool('rememberMe', false);

      emit(ProfileLogedOut());
    } catch (e) {
      emit(ProfileLogOutError(message: e.toString()));
    }
  }

  // UpdatePassword Function
  Future<void> updatePassword(String newPassword) async {
    emit(UpdateingPassword());
    try {
      await _profileAuthServices.updatePassword(newPassword);
      emit(UpdatedPassword());
    } catch (e) {
      emit(UpdatePasswordError(message: e.toString()));
    }
  }

  // GetUserData Function
  Future<UserData?> getUserData() async {
    emit(AccountPageLoading());
    try {
      final UserData userData = await _profileAuthServices.getUserData();
      emit(AccountPageLoaded(
        email: userData.email,
        fName: userData.firstName,
        lName: userData.lasttName,
        phone: userData.phoneNumber,
        birthDate: userData.birthDate,
      ));
    } catch (e) {
      emit(AccountPageError(message: e.toString()));
    }
    return null;
  }
}
