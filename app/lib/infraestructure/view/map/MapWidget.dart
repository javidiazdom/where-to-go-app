import 'dart:convert';

import 'package:app/infraestructure/view/map/MapInteraction.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:developer';
import '../constants/MapboxConfig.dart';

class MapWidget extends StatefulWidget {
  final MapInteraction mapInteraction;

  const MapWidget(this.mapInteraction);

  @override
  State createState() => MapWidgetState(mapInteraction);
}

class MapWidgetState extends State<MapWidget> {
  MapboxMapController mapController;
  MapInteraction mapInteraction;

  MapWidgetState(this.mapInteraction);

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    this.mapInteraction.setMapController(controller);
  }

  void _onMapClick(point, LatLng coordinates) async {
    List<dynamic> features = await mapController.queryRenderedFeatures(point, [
      "poi-label"
    ], [
      "==",
      ["get", "type"],
      [""]
    ]);
    if (features.length > 0 && features[0] != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(bearing: 270.0, target: coordinates, zoom: 17.0)));
      //log(features[0]);
      this.mapInteraction.scrollPanelToPosition(0.5);
      log(jsonDecode(features[0])['geometry']['coordinates'].toString());
      this.mapInteraction.setPlace(
          jsonDecode(features[0])['properties']['name'],
          coordinates,
          this.context);
    }
  }

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
