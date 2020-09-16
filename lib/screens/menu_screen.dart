import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rubios_restaurants/utilities/constants.dart';
import 'package:rubios_restaurants/utilities/cuisines.dart';
import 'dart:io' show Platform;

class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCuisine = 'Asian';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String cuisine in cuisines) {
      var newItem = DropdownMenuItem(
        child: Text(cuisine),
        value: cuisine,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCuisine,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCuisine = value;
//          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String cuisine in cuisines) {
      pickerItems.add(Text(
        cuisine,
        style: TextStyle(color: Colors.black),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.teal[100],
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCuisine = cuisines[selectedIndex];
//          getData();
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'What you feeling?',
            style: kHeadingStyle,
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
//            color: Colors.teal[100],
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
