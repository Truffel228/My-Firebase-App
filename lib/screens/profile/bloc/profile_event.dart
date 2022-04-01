part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {
  ProfileFetchEvent(this.uuid);
  final String uuid;
}

class ProfileSaveEvent extends ProfileEvent {
  ProfileSaveEvent({required this.userData, required this.uuid});
  final UserData userData;
  final String uuid;
}
