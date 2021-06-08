import 'dart:developer';
import 'package:app/infraestructure/http/HttpException.dart';
import 'package:app/infraestructure/repositories/SearchRepository.dart';
import 'package:app/infraestructure/view/map/MapInteraction.dart';
import 'package:app/infraestructure/view/widgets/AlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class SearchBox extends StatefulWidget {
  MapInteraction controller;
  SearchBox(this.controller);
  @override
  SearchBoxState createState() {
    return SearchBoxState(controller);
  }
}

class SearchBoxState extends State<SearchBox> {
  MapInteraction controller;
  SearchBoxState(this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Color(0xff666666), borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onTap: () {
          controller.scrollPanelToPosition(0.6);
        },
        onSubmitted: (search) async {
          try {
            LatLng proximityBias = await controller.getCurrentCoordinates();
            SearchResponse searchResult =
                await SearchRepository.searchPlace(search, proximityBias);
            controller.goToCoordinates(searchResult.coordinates);
            controller.setPlace(
                searchResult.placeName, searchResult.coordinates, this.context);
          } on HttpException catch (error) {
            await CustomAlertDialog.showCustomDialog(context, error.message);
          }
        },
        style: TextStyle(color: Color(0xffC9C9C9)),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 7),
            hintStyle: TextStyle(color: Color(0xffA6A6A6)),
            hintText: 'Buscar lugar o dirección',
            isDense: true,
            icon: Icon(Icons.search),
            fillColor: Color(0xffC9C9C9),
            focusColor: Color(0xffC9C9C9),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
