part of 'profile_image_bloc.dart';

@immutable
abstract class ProfileImageState extends Equatable {
  const ProfileImageState();
}

//TODO: Уточнить момент с оверрайдом ==
class ProfileImageInitial extends ProfileImageState {
  const ProfileImageInitial();
  @override
  bool operator ==(Object? other) {
    return false;
  }

  @override
  List<Object?> get props => [];

  @override
  int get hashCode => 0;
}

class ProfileImageLoadSuccess extends ProfileImageState {
  const ProfileImageLoadSuccess();
  @override
  bool operator ==(Object? other) {
    return false;
  }

  @override
  List<Object?> get props => [];

  @override
  int get hashCode => 0;
}

class ProfileImageNoGalleryAccess extends ProfileImageState {
  const ProfileImageNoGalleryAccess();
  bool operator ==(Object? other) {
    return false;
  }

  @override
  List<Object?> get props => [];

  @override
  int get hashCode => 0;
}

class ProfileImageNoCameraAccess extends ProfileImageState {
  const ProfileImageNoCameraAccess();
  bool operator ==(Object? other) {
    return false;
  }

  @override
  List<Object?> get props => [];

  @override
  int get hashCode => 0;
}

class ProfileImageDeleteSuccess extends ProfileImageState {
  @override
  List<Object?> get props => [];
}
