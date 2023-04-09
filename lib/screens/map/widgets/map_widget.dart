import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/add_map_comment/add_map_comment_screen.dart';
import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/map/widgets/comment_button.dart';
import 'package:fire_base_app/screens/map/widgets/map_button.dart';
import 'package:fire_base_app/screens/map/widgets/map_comment_marker.dart';
import 'package:fire_base_app/screens/map/widgets/map_comment_marker_cluster.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

const Duration commentFormAnimationDuration = Duration(milliseconds: 500);

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key,
      required this.userPosition,
      required this.mapComments,
      this.isCommentSaving = false,
      required this.cameraPosition})
      : super(key: key);
  final Position? userPosition;
  final List<MapComment> mapComments;
  final bool isCommentSaving;
  final Position? cameraPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _mapController = MapController();
  final _commentController = TextEditingController();
  late final String appUserUid;

  @override
  void initState() {
    super.initState();
    appUserUid = context.read<AppUser?>()!.uid;
    print('Map Widget init');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onPositionChanged: _onCameraPositionChanged,
              plugins: [
                MarkerClusterPlugin(),
              ],
              interactiveFlags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.pinchMove,
              minZoom: 3,
              maxZoom: 18,

              /// Moscow center if cameraPosition is null
              center: widget.cameraPosition != null
                  ? LatLng(
                      widget.cameraPosition!.latitude,
                      widget.cameraPosition!.longitude,
                    )
                  : LatLng(55.754617, 37.622554),
              zoom: 15,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://tile2.maps.2gis.com/tiles?x={x}&y={y}&z={z}&v=1&ts=online_hd',
              ),

              MarkerClusterLayerOptions(
                maxClusterRadius: 70,
                size: Size(40, 40),
                fitBoundsOptions: FitBoundsOptions(padding: EdgeInsets.all(50)),
                spiderfyCircleRadius: 100,
                centerMarkerOnClick: true,
                showPolygon: false,
                builder: (BuildContext context, List<Marker> markers) {
                  if (markers == null || markers.isEmpty) {
                    return const SizedBox();
                  }
                  return MapCommentMarkerCluster(
                    text: markers.length.toString(),
                  );
                },
                markers: widget.mapComments.isNotEmpty
                    ? _getMarkersFromComments(widget.mapComments)
                    : [],
              ),

              /// Marker for user position
              MarkerLayerOptions(
                markers: [
                  if (widget.userPosition != null)
                    Marker(
                      builder: (BuildContext context) {
                        return IgnorePointer(
                          ignoring: true,
                          child: Icon(
                            FontAwesomeIcons.locationCrosshairs,
                            color: theme.primaryColor,
                            size: 20,
                          ),
                        );
                      },
                      point: LatLng(widget.userPosition!.latitude,
                          widget.userPosition!.longitude),
                    ),
                ],
              ),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Center(
            heightFactor: 18.8,
            child: Icon(
              FontAwesomeIcons.mapPin,
              color: theme.primaryColor,
              size: 30,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 20,
          child: Column(
            children: [
              MapButton(icon: FontAwesomeIcons.plus, onTap: _zoomIn),
              const SizedBox(height: 15),
              MapButton(icon: FontAwesomeIcons.minus, onTap: _zoomOut),
              const SizedBox(height: 15),
              MapButton(
                  icon: FontAwesomeIcons.locationCrosshairs,
                  onTap: _focusOnUser),
            ],
          ),
        ),

        /// Save map comment button
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.isCommentSaving
                  ? const LoadingWidget()
                  : CommentButton(
                      onTap: _onCommentButtonTap,
                    ),
            ),
          ),
        ),
        // CommentForm(
        //   animationDuration: commentFormAnimationDuration,
        //   controller: _commentController,
        //   isCommentOpen: isCommentOpen,
        //   isCommentShowInner: isCommentShowInner,
        //   onApplyTap: _onFormApplyTap,
        //   onCancelTap: _onFormCancelTap,
        // ),
      ],
    );
  }

  // void _onPositionChanged(mapPosition, boolValue) {
  //   print('position on map has changed');
  //   final LatLng userPosition = LatLng(
  //       mapPosition.center!.latitude,
  //       mapPosition.center!.longitude);
  //   final LatLng cameraPosition = LatLng(
  //       _mapController.center.latitude,
  //       _mapController.center.longitude);
  //   context.read<MapBloc>().add(
  //     MapPositionChangedEvent(
  //         userPosition: userPosition,
  //         cameraPosition: cameraPosition),
  //   );
  // }
  void _onCameraPositionChanged(MapPosition position, bool hasGesture) {
    final cameraPosition = Position(
      latitude: position.center!.latitude,
      longitude: position.center!.longitude,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      timestamp: null,
    );
    context.read<MapBloc>().add(
          MapCameraPositionChangedEvent(cameraPosition),
        );
  }

  List<Marker> _getMarkersFromComments(List<MapComment> mapComments) {
    final list = mapComments
        .map(
          (comment) => Marker(
            builder: (BuildContext context) => MapCommentMarker(
              mapComment: comment,
            ),
            point: LatLng(comment.latitude, comment.longitude),
          ),
        )
        .toList();
    return list;
  }

  // void _onFormApplyTap(Category category) {
  //   FocusScope.of(context).unfocus();
  //   context.read<MapBloc>().add(
  //         MapSaveCommentEvent(
  //           mapCommentContent: _commentController.text,
  //           mapCommentLatitude: _mapController.center.latitude,
  //           mapCommentLongitude: _mapController.center.longitude,
  //           mapCommentUserId: appUserUid,
  //           category: category,
  //         ),
  //       );
  //   _commentController.clear();
  //   Navigator.of(context).pop();
  // }

  // void _onFormCancelTap() {
  //   FocusScope.of(context).unfocus();
  //   _commentController.clear();
  //   Navigator.of(context).pop();
  // }

  void _zoomIn() {
    final zoom = _mapController.zoom + 1;
    final center = _mapController.center;
    _mapController.move(center, zoom);
  }

  void _zoomOut() {
    final zoom = _mapController.zoom - 1;
    final center = _mapController.center;
    _mapController.move(center, zoom);
  }

  void _focusOnUser() {
    if (widget.userPosition != null) {
      _mapController.move(
        LatLng(
          widget.userPosition!.latitude,
          widget.userPosition!.longitude,
        ),
        _mapController.zoom,
      );
    }
  }

  void _onCommentButtonTap() {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) => AddMapCommentForm(


        controller: _commentController,
        latitude: _mapController.center.latitude,
        longitude: _mapController.center.longitude,
      ),
    );
  }
}
