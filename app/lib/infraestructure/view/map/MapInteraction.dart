import 'dart:developer';

import 'package:app/domain/models/Place.dart';
import 'package:app/infraestructure/repositories/Ratings.repository.dart';
import 'package:app/infraestructure/view/widgets/PlaceDisplay.dart';
import 'package:flutter/material.dart';
import '../../http/HttpException.dart';
import 'package:app/infraestructure/repositories/Location.repository.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapInteraction {
  MapboxMapController mapController;
  PanelController panelController;
  GlobalKey<PlaceDisplayState> placeDisplayKey;

  void setPanelController(PanelController newPanelController) {
    this.panelController = newPanelController;
  }

  void setMapController(MapboxMapController newMapController) {
    this.mapController = newMapController;
  }

  void setPlaceDisplayKey(GlobalKey<PlaceDisplayState> newPlaceDisplayKey) {
    this.placeDisplayKey = newPlaceDisplayKey;
  }

  void setPlace(
      String placeName, LatLng coordinates, BuildContext context) async {
    try {
      log(coordinates.toString());
      var place = await LocationRepository.getLocation(
          new PlaceLatLng(coordinates.latitude, coordinates.longitude));
      this.placeDisplayKey.currentState.setPlace(place);
      var ratingData = await RatingsRepository.getLocationRatings(place);
      this.placeDisplayKey.currentState.setRatingData(ratingData.averages,
          ratingData.mainAverage, ratingData.averagesCount);
    } on HttpException catch (error) {
      this.placeDisplayKey.currentState.clearPlace();
      this.placeDisplayKey.currentState.setUnregisteredPlace(
          new UnregisteredPlace(placeName,
              new PlaceLatLng(coordinates.latitude, coordinates.longitude)));
      this.placeDisplayKey.currentState.setErrorMessage(error.toString());
    }
  }

  void scrollPanelToPosition(double height) {
    this.panelController.animatePanelToPosition(height);
  }

  void goToCoordinates(LatLng coordinates) {
    this.mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 270.0, target: coordinates, zoom: 17.0)));
  }

  Future<LatLng> getCurrentCoordinates() async {
    var region = await this.mapController.getVisibleRegion();
    return region.northeast;
  }
}
