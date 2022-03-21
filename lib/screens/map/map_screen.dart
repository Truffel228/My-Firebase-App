import 'package:fire_base_app/screens/map/widgets/map_widget.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapWidget(),
      ],
    );
  }
}
