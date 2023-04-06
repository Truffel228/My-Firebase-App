part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final UserModel userData;
  final String? message;
  const ProfileLoaded({required this.userData, this.message});

  @override
  List<Object?> get props => [userData, message];
}

class ProfileSaving extends ProfileState {
  final UserModel userData;
  const ProfileSaving({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class ProfileCommentDeleteSuccess extends ProfileState {
  const ProfileCommentDeleteSuccess();
  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileState {
  const ProfileError({
    required this.userData,
    required this.message,
  });
  final UserModel userData;
  final String message;

  @override
  List<Object?> get props => [userData, message];
}
