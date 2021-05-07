import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../constants/MapboxConfig.dart';

class MapWidget extends StatefulWidget {
  const MapWidget();

  @override
  State createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onMapClick(point, LatLng coordinates) async {}

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(28.196441460862967, -15.770094857255247), zoom: 5.5),
        accessToken: accessToken,
        styleString: styleUrl,
        onMapClick: _onMapClick,
        onMapCreated: _onMapCreated);
  }
}
