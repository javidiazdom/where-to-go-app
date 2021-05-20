import 'package:app/domain/models/Place.dart';
import 'package:app/domain/models/Rating.dart';
import 'package:app/infraestructure/view/widgets/PlaceDisplay.dart';
import 'package:flutter/material.dart';
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

  void setPlace(String placeName, BuildContext context) {
    var place = new Place(placeName);
    place.addRating(new Rating("Prueba", 4.5));
    this.placeDisplayKey.currentState.setPlace(place);
  }

  void scrollPanelToPosition(double height) {
    this.panelController.animatePanelToPosition(height);
  }
}
