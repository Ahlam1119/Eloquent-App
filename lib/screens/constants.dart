import 'package:flutter/material.dart';

const kStylingInputDec = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff9BB0A5), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 83, 97, 90), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
//هذا للنص الكبير
const KStyleHedaer = TextStyle(
  color: Color(0xff394445),
  fontSize: 20,
  fontFamily: "Cairo",
  fontWeight: FontWeight.w700,
);
//this for the text apove the TextFeild
const SStyleTextOfTextFeild = TextStyle(
  color: Color(0xff385a4a),
  fontSize: 14,
  fontFamily: "Cairo",
  fontWeight: FontWeight.w600,
);
