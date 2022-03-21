part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserData userData;
  final String? message;
  ProfileLoaded({required this.userData, this.message});
}

class ProfileSaving extends ProfileState {
  final UserData userData;
  ProfileSaving({required this.userData});
}

class ProfileError extends ProfileState {
  ProfileError({
    required this.userData,
    required this.message,
  });
  final UserData userData;
  final String message;
}
