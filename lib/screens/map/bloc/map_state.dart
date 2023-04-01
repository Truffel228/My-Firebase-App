// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class MapLoading extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoaded extends MapState {
  final LatLng? userPosition;
  final LatLng? cameraPosition;
  final List<MapComment> mapComments;
  final bool isCommentSaving;

  const MapLoaded({
    required this.cameraPosition,
    required this.userPosition,
    required this.mapComments,
    this.isCommentSaving = false,
  });

  @override
  List<Object?> get props => [userPosition, mapComments, cameraPosition];

  MapLoaded copyWith({
    LatLng? userPosition,
    LatLng? cameraPosition,
    List<MapComment>? mapComments,
    bool? isCommentSaving,
  }) {
    return MapLoaded(
      userPosition: userPosition ?? this.userPosition,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      mapComments: mapComments ?? this.mapComments,
      isCommentSaving: isCommentSaving ?? this.isCommentSaving,
    );
  }
}

// class MapCommentSaving extends MapLoaded {
//   const MapCommentSaving(
//       {required LatLng? cameraPosition,
//       required LatLng? userPosition,
//       required List<MapComment> mapComments})
//       : super(
//             cameraPosition: cameraPosition,
//             userPosition: userPosition,
//             mapComments: mapComments);

//   @override
//   List<Object?> get props => [mapComments, userPosition, cameraPosition];
// }
