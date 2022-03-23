part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState{
  final Position? position;
  MapLoaded({this.position});
}
