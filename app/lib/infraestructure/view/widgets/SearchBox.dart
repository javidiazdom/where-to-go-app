import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  SearchBoxState createState() {
    return SearchBoxState();
  }
}

class SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xff666666), borderRadius: BorderRadius.circular(10)),
      child: TextField(
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
