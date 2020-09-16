import 'package:flutter/material.dart';
import 'package:rubios_restaurants/utilities/constants.dart';

class LocationRow extends StatelessWidget {
  LocationRow({
    this.price,
    this.cuisine,
    @required this.location,
    this.redirect,
  });

  final String price;
  final String cuisine;
  final String location;
  final Function redirect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(price != null ? 'Price: $price' : '$cuisine',
            style: price != null ? kTextBodyStyle : kBlueTextStyle),
//        Row(
//          children: <Widget>[
//            Icon(Icons.location_on, color: Colors.red, size: 20),
//            SizedBox(width: 3),
//            Text('$location',
//                style: kTextBodyStyle),
//          ],
//        ),
        RaisedButton(
          color: kDarkColour,
          child: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.red, size: 20),
              SizedBox(width: 5),
              Text('$location', style: kTextBodyStyle),
            ],
          ),
          onPressed: redirect,
        ),
      ],
    );
  }
}
