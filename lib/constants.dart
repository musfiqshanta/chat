import 'package:flutter/material.dart';

const textStyleHeading = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Color(0xff341f97),
);

const textStylePara = TextStyle(fontSize: 18.0);
const buttonStyle = TextStyle(fontSize: 18.0, color: Colors.white);
const inputDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
    color: Color(0xff341f97),
  )),
  //label: Text(label),
  labelStyle: TextStyle(
    color: Color(0xff341f97),
  ),
  focusColor: Color(0xff341f97),
);
