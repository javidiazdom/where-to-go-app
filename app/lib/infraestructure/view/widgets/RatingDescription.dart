import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDescription extends StatelessWidget {
  String name;
  String description;
  VoidCallback Function(double) setRating;
  RatingDescription(this.name, this.description, this.setRating);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xff585C5C).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 15,
                spreadRadius: 5)
          ]),
      padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  this.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  size: 1.0,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setRating(rating);
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.description,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}
