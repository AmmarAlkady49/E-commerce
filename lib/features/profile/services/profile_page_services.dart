import 'package:e_commerce_graduation/core/models/user_data.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ProfilePageServices {
  Future<void> signOut();
  Future<void> signoutFromGoogle();
  Future<void> updatePassword(String newPassword);
  Future<UserData> getUserData();
}

class ProfilePageServicesimpl implements ProfilePageServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signoutFromGoogle() async {
    await GoogleSignIn().signOut();
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<UserData> getUserData() async {
    final userData = await _firestoreServices.getDocument(
      path: ApiPathes.users(_firebaseAuth.currentUser!.uid),
      builder: (data, documentID) {
        return UserData.fromMap(data);
      },
    );
    return userData;
  }
}
