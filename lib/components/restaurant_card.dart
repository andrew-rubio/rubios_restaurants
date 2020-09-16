import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../screens/restaurant_detail.dart';
import 'location_row.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({
    this.resID,
    this.name,
    this.cuisine,
    this.location,
    this.image,
    this.price,
    this.description,
  });

  final String resID;
  final String name;
  final String cuisine;
  final String location;
  final String image;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetail(
              resID: resID,
              name: name,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kDarkColour,
        ),
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: NetworkImage('$image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$name', style: kHeadingStyle),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('$cuisine', style: kBlueTextStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('$description', style: kTextBodyStyle),
                  ),
                  LocationRow(price: price, location: location),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
