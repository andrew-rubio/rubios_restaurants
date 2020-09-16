import 'package:flutter/material.dart';
import 'package:rubios_restaurants/utilities/constants.dart';
import 'package:rubios_restaurants/components/location_row.dart';
import 'package:rubios_restaurants/services/restaurants.dart';
import 'package:rubios_restaurants/services/google_places.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetail extends StatefulWidget {
  static const String id = 'restaurant_detail';

  RestaurantDetail({
    this.resID,
    this.name,
  });

  final String resID;
  final String name;

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  var restaurantData;
  var placeDetailData;
  bool isWaiting = true;
  bool isWaitingPlace = true;

  // to pull from Airtable
  String name,
      website,
      description,
      recommendation,
      location,
      price,
      cuisine,
      image;

  // to pull from Google API
  String phoneNumber,
      reviewTime0,
      reviewText0,
      reviewTime1,
      reviewText1,
      reviewTime2,
      reviewText2;
  List<String> reviewTimes = [];
  List<String> reviewTexts = [];
  double rating;
  int ratingsTotal;

  RestaurantModel restaurantModel = RestaurantModel();
  GooglePlace googlePlace = GooglePlace();

  void getRestaurantItemData() async {
    try {
      var data = await restaurantModel.getRestaurantItem(widget.resID);
      isWaiting = false;
      setState(() {
        restaurantData = data;
        name = restaurantData['fields']['Name'];
        website = restaurantData['fields']['Website'];
        description = restaurantData['fields']['Description'];
        recommendation = restaurantData['fields']['Recommendation'];
        location = restaurantData['fields']['Location'];
        price = restaurantData['fields']['Price'];
        cuisine = restaurantData['fields']['Cuisine'];
        image = restaurantData['fields']['Image'];
      });
    } catch (e) {
      print(e);
    }
  }

  void getRestaurantDetail() async {
    try {
      // search google with restaurant "Name"
      var placeListData = await googlePlace.findPlaces(widget.name);
      // grab first result
      var placeFirstID = placeListData['candidates'][0]['place_id'];
      // get all details from first result
      var data = await googlePlace.getPlaceDetails(placeFirstID);
      isWaitingPlace = false;

      setState(() {
        placeDetailData = data;
        phoneNumber = placeDetailData['result']['formatted_phone_number'];
        rating = placeDetailData['result']['rating'];
        ratingsTotal = placeDetailData['result']['user_ratings_total'];

        for (var i = 0;
            (i < 3 && i < placeDetailData['result']['reviews'].length);
            i++) {
          reviewTimes.add(placeDetailData['result']['reviews'][i]
              ['relative_time_description']);
          reviewTexts.add(placeDetailData['result']['reviews'][i]['text']);
//          i < placeDetailData['result']['reviews'].length ||
//          reviewText = placeDetailData['result']['reviews'][0]['text'];
        }
      });

//      String jsonBody =
//          '{"fields":{"Website":"${getPlaceDetailField('website')}","Price":"${outputPrice()}","Location":"${getPlaceLocation()}","Name":"${getPlaceDetailField('name')}","Description":"Done"}}';
//      print(jsonBody);
//      var updatedData =
//          await restaurantModel.updateRestaurantItem(widget.resID, '$jsonBody');
//      print(updatedData);
    } catch (e) {
      print(e);
    }
  }

//  String outputPrice() {
//    int count = double.parse(getPlaceDetailField('price_level')).toInt();
//
//    String price = '';
//    for (int i = 0; i < count; i++) {
//      price = price + '£';
//    }
//    return price;
//  }

  @override
  void initState() {
    super.initState();
    getRestaurantItemData();
    getRestaurantDetail();
  }

  String getField(field) {
    return '${isWaiting || isWaitingPlace || field == null ? '' : field}';
  }

  Column showReviews() {
    List<Widget> reviewList = [];

    for (int i = 0; i < reviewTimes.length; i++) {
//      print(reviewTimes[i]);
//      print(reviewTexts[i]);
      reviewList.add(
        Text(
          getField(reviewTimes[i]),
          style: kTextBodyItalicsStyle,
        ),
      );
      reviewList.add(SizedBox(height: 10));
      reviewList.add(
        Text(
          getField(reviewTexts[i]),
          style: kTextBodyStyle,
        ),
      );
      reviewList.add(SizedBox(height: 20));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reviewList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getField(name), style: kHeadingStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(getField(image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LocationRow(
                      cuisine: getField(cuisine).toUpperCase(),
                      location: getField(location),
                      redirect: () {
                        MapUtils.openMap(
                            isWaitingPlace ? '' : name.replaceAll(' ', '%20'));
                      }),
//                  Text(getField(cuisine).toUpperCase(), style: kBlueTextStyle),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Price: ${getField(price)}',
                        style: kTextBodyStyle),
                  ),
                  Visibility(
                    visible: !isWaitingPlace && phoneNumber != null,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(getField(phoneNumber),
                            style: kTextBodyUnderlinedStyle),
                      ),
                      onTap: () => launch(
                          "tel:${isWaitingPlace ? '' : phoneNumber.replaceAll(' ', '')}"),
                    ),
                  ),
                  Visibility(
                    visible: !isWaitingPlace && website != null,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Visit Website',
                            style: kTextBodyUnderlinedStyle),
                      ),
                      onTap: () => launch(getField(website)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 8),
                    child: Text(
                      'Google Rating',
                      style: kMediumStyle,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Color(0xFFFFDF00),
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '${getField(rating)} ${isWaitingPlace ? '' : '('}${getField(ratingsTotal)}${isWaitingPlace ? '' : ')'}',
                        style: kTextBodyBoldStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 8),
                    child: Text(
                      'Description',
                      style: kMediumStyle,
                    ),
                  ),
                  Text(
                    getField(description),
                    style: kTextBodyStyle,
                  ),
                  Visibility(
                    visible: getField(recommendation) != '',
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 8),
                      child: Text(
                        getField(recommendation) == ''
                            ? ''
                            : 'My recommendation',
                        style: kMediumStyle,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: getField(recommendation) != '',
                    child: Text(
                      getField(recommendation),
                      style: kTextBodyStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 8),
                    child: Text(
                      'Reviews from Google',
                      style: kMediumStyle,
                    ),
                  ),
//                  Text(
//                    getField(reviewTimes[0]),
//                    style: kTextBodyItalicsStyle,
//                  ),
//                  SizedBox(height: 10),
//                  Text(
//                    getField(reviewTexts[0]),
//                    style: kTextBodyStyle,
//                  ),
                  showReviews(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String locationName) async {
    String googleUrl = 'https://www.google.com/maps/search/$locationName/';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
