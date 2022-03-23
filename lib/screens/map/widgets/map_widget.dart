import 'package:fire_base_app/screens/map/widgets/comment_button.dart';
import 'package:fire_base_app/screens/map/widgets/map_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.userPosition}) : super(key: key);
  final Position? userPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            minZoom: 3,
            maxZoom: 18,
            center: widget.userPosition != null
                ? LatLng(widget.userPosition!.latitude,
                    widget.userPosition!.longitude)
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
                      return Icon(FontAwesomeIcons.locationCrosshairs);
                    },
                    point: LatLng(widget.userPosition!.latitude,
                        widget.userPosition!.longitude),
                  ),
              ],
            ),
          ],
        ),
        IgnorePointer(
          ignoring: true,
          child: Center(
            heightFactor: 100,
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
              MapButton(icon: FontAwesomeIcons.plus, onTap: _zoomIn),
              const SizedBox(height: 15),
              MapButton(icon: FontAwesomeIcons.minus, onTap: _zoomOut),
              const SizedBox(height: 15),
              MapButton(
                  icon: FontAwesomeIcons.locationCrosshairs, onTap: () {}),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommentButton(),
            ),
          ),
        ),
      ],
    );
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
}
