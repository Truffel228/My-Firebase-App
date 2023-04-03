part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final UserModel userData;
  final String? message;
  ProfileLoaded({required this.userData, this.message});

  @override
  List<Object?> get props => [userData, message];
}

class ProfileSaving extends ProfileState {
  final UserModel userData;
  ProfileSaving({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class ProfileError extends ProfileState {
  ProfileError({
    required this.userData,
    required this.message,
  });
  final UserModel userData;
  final String message;

  @override
  // TODO: implement props
  List<Object?> get props => [userData, message];
}
