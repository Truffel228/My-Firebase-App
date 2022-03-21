import 'package:firebase_auth/firebase_auth.dart';

class AppUser {

  AppUser({required this.uid, required this.isAnon});
  final String uid;
  final bool isAnon;

  factory AppUser.fromFirebaseUser(User user){
    return AppUser(uid: user.uid, isAnon: user.isAnonymous);
  }

}
