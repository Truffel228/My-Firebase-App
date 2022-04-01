import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/map/widgets/comment_button.dart';
import 'package:fire_base_app/screens/map/widgets/comment_form.dart';
import 'package:fire_base_app/screens/map/widgets/map_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

const Duration commentFormAnimationDuration = Duration(milliseconds: 500);

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.userPosition}) : super(key: key);
  final LatLng? userPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _mapController = MapController();
  bool isCommentOpen = false;
  bool isCommentShowInner = false;
  final _commentController = TextEditingController();
  late final String appUserUid;

  @override
  void initState() {
    super.initState();
    appUserUid = context.read<AppUser?>()!.uid;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            print('dlaf');
          },
          child: IgnorePointer(
            ignoring: isCommentOpen,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.pinchMove,
                minZoom: 3,
                maxZoom: 18,
                center: widget.userPosition != null
                    ? LatLng(widget.userPosition!.latitude,
                        widget.userPosition!.longitude)

                    ///Coordinates of Moscow center
                    : LatLng(55.754617, 37.622554),
                zoom: 15,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://tile2.maps.2gis.com/tiles?x={x}&y={y}&z={z}&v=1&ts=online_hd',
                ),
                MarkerLayerOptions(
                  markers: [
                    if (widget.userPosition != null)
                      Marker(
                        builder: (BuildContext context) {
                          return Icon(
                            FontAwesomeIcons.locationCrosshairs,
                            color: theme.primaryColor,
                            size: 20,
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
          top: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              MapButton(
                  icon: FontAwesomeIcons.plus,
                  onTap: isCommentOpen ? () {} : _zoomIn),
              const SizedBox(height: 15),
              MapButton(
                  icon: FontAwesomeIcons.minus,
                  onTap: isCommentOpen ? () {} : _zoomOut),
              const SizedBox(height: 15),
              MapButton(
                  icon: FontAwesomeIcons.locationCrosshairs,
                  onTap: isCommentOpen ? () {} : _focusOnUser),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CommentButton(
                onTap: () async {
                  setState(() {
                    isCommentOpen = true;
                  });
                  await Future.delayed(commentFormAnimationDuration);
                  setState(() {
                    isCommentShowInner = true;
                  });
                },
              ),
            ),
          ),
        ),
        CommentForm(
          animationDuration: commentFormAnimationDuration,
          controller: _commentController,
          isCommentOpen: isCommentOpen,
          isCommentShowInner: isCommentShowInner,
          onApplyTap: _onFormApplyTap,
          onCancelTap: _onFormCancelTap,
        ),
      ],
    );
  }

  void _onFormApplyTap() {
    setState(() {
      isCommentOpen = false;
      isCommentShowInner = false;
    });
    FocusScope.of(context).unfocus();
    context.read<MapBloc>().add(
          MapSaveCommentEvent(
            mapCommentContent: _commentController.text,
            mapCommentLatitude: _mapController.center.latitude,
            mapCommentLongitude: _mapController.center.longitude,
            mapCommentUserId: appUserUid,
          ),
        );
    _commentController.clear();
    print('event is sent');
  }

  void _onFormCancelTap() {
    setState(() {
      isCommentOpen = false;
      isCommentShowInner = false;
    });
    FocusScope.of(context).unfocus();
  }

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
      _mapController.move(widget.userPosition!, _mapController.zoom);
    }
  }
}
