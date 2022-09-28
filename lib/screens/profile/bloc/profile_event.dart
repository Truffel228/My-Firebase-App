part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileFetchEvent extends ProfileEvent {
  ProfileFetchEvent(this.uuid);
  final String uuid;

  @override
  List<Object?> get props => [uuid];
}

class ProfileSaveEvent extends ProfileEvent {
  ProfileSaveEvent({required this.userData, required this.userId});
  final UserData userData;
  final String userId;

  @override
  List<Object?> get props => [userId, userData];
}

class ProfileSaveAfterDeleteCommentEvent extends ProfileSaveEvent {
  ProfileSaveAfterDeleteCommentEvent({
    required String userId,
    required this.deletedCommentId,
    required UserData userData,
  }) : super(userData: userData, userId: userId);
  final String deletedCommentId;

  @override
  List<Object?> get props => [deletedCommentId];
}
