part of 'profile_image_bloc.dart';

@immutable
abstract class ProfileImageEvent extends Equatable {
  const ProfileImageEvent();
}

class ProfileImagePickGallery extends ProfileImageEvent {
  const ProfileImagePickGallery(this.uid);
  final String uid;
  @override
  List<Object?> get props => [];
}

class ProfileImageTakePhoto extends ProfileImageEvent {
  const ProfileImageTakePhoto(this.uid);
  final String uid;
  @override
  List<Object?> get props => [];
}

class ProfileImageDeletePhoto extends ProfileImageEvent {
  const ProfileImageDeletePhoto(this.uid);
  final String uid;
  @override
  List<Object?> get props => [];
}
