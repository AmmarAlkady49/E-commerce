import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  User? getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<void> signoutFromGoogle();
  Future<UserCredential> signinWithGoogle();
  Future<void> updatePassword(String emailText);
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredintial = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredintial.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.setLanguageCode("en");
    return _firebaseAuth.currentUser!.sendEmailVerification();
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return Future.error('Google sign-in aborted');
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signoutFromGoogle() {
    return GoogleSignIn().signOut();
  }

  @override
  Future<void> updatePassword(String emailText) async {
    await _firebaseAuth.sendPasswordResetEmail(email: emailText);
  }
}
