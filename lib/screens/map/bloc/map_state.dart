part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState{
  final LatLng? position;
  MapLoaded({this.position});
}
