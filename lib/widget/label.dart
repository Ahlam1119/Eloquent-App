import 'package:flutter/material.dart';

const InputDecoration docfiled = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(255, 255, 254, 254),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff385a4a),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff385a4a),
      width: 2,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
