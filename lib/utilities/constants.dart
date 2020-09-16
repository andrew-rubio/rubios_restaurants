import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBodySize = 14.0;
const kMediumSize = 20.0;
const kHeadingSize = 25.0;

const kDarkColour = Color(0xFF121212);

var kHeadingStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kHeadingSize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);

var kMediumStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kMediumSize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);

var kTextBodyStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kBodySize,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
);

var kTextBodyUnderlinedStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kBodySize,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.underline,
    color: Colors.white,
  ),
);

var kTextBodyItalicsStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kBodySize,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  ),
);

var kTextBodyBoldStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: kBodySize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);

var kBlueTextStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
  ),
);

const kTextFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
  filled: true,
  fillColor: Color(0xFFe5e5e5),
  hintText: 'search cuisine, name, location',
  hintStyle: TextStyle(
    color: Color(0xAA2c2c2c),
    fontSize: kBodySize,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
    ),
    borderSide: BorderSide.none,
  ),
);
