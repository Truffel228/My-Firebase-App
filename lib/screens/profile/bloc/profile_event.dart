part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {
  ProfileFetchEvent(this.uid);
  final String uid;
}

class ProfileSaveEvent extends ProfileEvent {
  ProfileSaveEvent({required this.userData, required this.uid});
  final UserData userData;
  final String uid;
}
