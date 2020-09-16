import 'package:flutter/material.dart';
import '../services/restaurants.dart';
import '../components/restaurant_card.dart';
import '../utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionScreen extends StatefulWidget {
  static const String id = 'selection_screen';

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String searchValue;

  RestaurantModel restaurantModel = RestaurantModel();

  var restaurantData;
  bool isWaiting = true;

  void getRestaurantData() async {
    try {
      var data = await restaurantModel.getRestaurantList();
      isWaiting = false;
      setState(() {
        restaurantData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void getRestaurantDataFromSearch(value) async {
    try {
      var data = await restaurantModel.getRestaurantSearch(value);
      isWaiting = false;
      setState(() {
        restaurantData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRestaurantData();
  }

  ListView getRestaurantCards() {
    List<RestaurantCard> restaurantCards = [];

    for (int i = 0;
        i < (isWaiting ? 0 : restaurantData['records'].length);
        i++) {
      var cardItem = RestaurantCard(
        resID: isWaiting ? '' : '${restaurantData['records'][i]['id']}',
        name: isWaiting
            ? ''
            : '${restaurantData['records'][i]['fields']['Name']}',
        cuisine: isWaiting
            ? ''
            : restaurantData['records'][i]['fields']['Cuisine'] == null
                ? ''
                : '${restaurantData['records'][i]['fields']['Cuisine'].toUpperCase()}',
        location: isWaiting
            ? ''
            : '${restaurantData['records'][i]['fields']['Location']}',
        image: isWaiting
            ? ''
            : '${restaurantData['records'][i]['fields']['Image']}',
        price: isWaiting
            ? ''
            : '${restaurantData['records'][i]['fields']['Price']}',
        description: isWaiting
            ? ''
            : '${restaurantData['records'][i]['fields']['Description']}',
      );

      restaurantCards.add(cardItem);
    }

    return ListView(
      children: restaurantCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rubio\'s Recommendations',
            style: GoogleFonts.poppins(textStyle: kHeadingStyle)),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 50,
                    child: TextField(
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: kBodySize,
                        ),
                      ),
                      decoration: kTextFieldInputDecoration,
                      onChanged: (value) {
                        searchValue = value;
                      },
                      onSubmitted: (value) {
                        getRestaurantDataFromSearch(searchValue);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      color: kDarkColour,
                      onPressed: () {
                        getRestaurantDataFromSearch(searchValue);
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: getRestaurantCards(),
          )
        ],
      ),
    );
  }
}
