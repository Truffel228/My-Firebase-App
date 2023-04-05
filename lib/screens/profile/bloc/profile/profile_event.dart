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
  final UserModel userData;
  final String userId;

  @override
  List<Object?> get props => [userId, userData];
}

class ProfileDeleteCommentEvent extends ProfileEvent {
  ProfileDeleteCommentEvent({
    required this.userId,
    required this.deletedCommentId,
  });

  final String userId;
  final String deletedCommentId;

  @override
  List<Object?> get props => [userId, deletedCommentId];
}
