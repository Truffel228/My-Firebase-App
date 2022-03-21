import 'package:fire_base_app/exceptions/service_exceptions/auth_service_exception.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements AuthServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _appUserFromUser(User? user) {
    return user != null ? AppUser.fromFirebaseUser(user) : null;
  }

  @override
  Stream<AppUser?> get onAuthStateChanged {
    return _auth.authStateChanges().map(_appUserFromUser);
  }

  @override
  Future<AppUser?> signInAnon() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      final User? user = userCredential.user;

      if (user == null) {
        print('Sign in anonymously Exception \n File: auth_service.dart');
        return null;
      }
      return AppUser.fromFirebaseUser(user);
    } catch (e) {
      print('Sign in anonymously Exception \n File: auth_service.dart');
      print(e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out Exception \n File: auth_service.dart');
      print(e);
    }
  }

  @override
  Future<AppUser?> signInEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user == null) {
        print('Sign in Exception \n File: auth_service.dart');
        return null;
      }
      return AppUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthServiceException(code: 'user-not-found');
        case 'wrong-password':
          throw AuthServiceException(code: 'wrong-password');
      }
      print(e);
    } catch (e) {
      print('Sign in Exception \n File: auth_service.dart');
      print(e);
      return null;
    }
  }

  @override
  Future<AppUser?> signUpEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user == null) {
        print('Sign up Exception \n File: auth_service.dart');
        return null;
      }
      return AppUser.fromFirebaseUser(user);
    } catch (e) {
      print('Sign up Exception \n File: auth_service.dart');
      print(e);
      return null;
    }
  }
}
