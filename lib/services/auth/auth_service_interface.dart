import 'package:fire_base_app/models/app_user/app_user.dart';

abstract class AuthServiceInterface{
  Future<AppUser?> signInAnon();
  Future<void> signOut();
  Future<AppUser?> signInEmailPassword(String email, String password);
  Future<AppUser?> signUpEmailPassword(String email, String password);
  Stream<AppUser?> get onAuthStateChanged;
}